import Foundation
import SwiftSoup

struct HomeViewState {
    let prayerTimes: [PrayerTime]
    let currentPrayerType: PrayerType?
    let loadingState: LoadingState
    let errorMessage: String
    let errorButtonMessage: String
    let khutbah1Time: String
    let khutbah2Time: String
    let khutbahCardTitle: String
    let prayerColumnTitle: String
    let athanColumnTitle: String
    let iqamaColumnTitle: String

    init(
        prayerTimes: [PrayerTime] = [],
        currentPrayerType: PrayerType? = nil,
        loadingState: LoadingState = .loading,
        errorMessage: String = HOME_ERROR_MESSAGE,
        errorButtonMessage: String = HOME_ERROR_BUTTON_MESSAGE,
        khutbah1Time: String = "",
        khutbah2Time: String = "",
        khutbahCardTitle: String = KHUTBAH_CARD_TITLE,
        prayerColumnTitle: String = PRAYER_COLUMN_TITLE,
        athanColumnTitle: String = ATHAN_COLUMN_TITLE,
        iqamaColumnTitle: String = IQAMA_COLUMN_TITLE
    ) {
        self.prayerTimes = prayerTimes
        self.currentPrayerType = currentPrayerType
        self.loadingState = loadingState
        self.errorMessage = errorMessage
        self.errorButtonMessage = errorButtonMessage
        self.khutbah1Time = khutbah1Time
        self.khutbah2Time = khutbah2Time
        self.khutbahCardTitle = khutbahCardTitle
        self.prayerColumnTitle = prayerColumnTitle
        self.athanColumnTitle = athanColumnTitle
        self.iqamaColumnTitle = iqamaColumnTitle
    }
}

struct PrayerTime {
    let type: PrayerType
    let prayerTime: String
    let iqamaTime: String?
    let dateTime: Date?
}

enum PrayerType: String {
    case fajr = "Fajr"
    case sunrise = "Sunrise"
    case dhuhr = "Dhuhr"
    case asr = "Asr"
    case maghrib = "Maghrib"
    case isha = "Isha'a"
    case khutbah1 = "Arabic/English"
    case khutbah2 = "Kurdish/English"
    
    var prayerName: String {
        return self.rawValue
    }
}

enum LoadingState {
    case loading
    case error
    case success
}

class HomeViewModel: ObservableObject {
    @Published var state: HomeViewState
    
    init(state: HomeViewState = HomeViewState()) {
        self.state = state
        fetchPrayerData()
    }
    
    func errorButtonOnClick() {
        fetchPrayerData()
    }
    
    func scrapeIqamaTimes(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: IQAMA_TIME_URL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "Invalid Data", code: 2, userInfo: nil)))
                return
            }
            
            do {
                let document = try SwiftSoup.parse(html)
                let bodyText = try document.text()
                completion(.success(bodyText))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func fetchPrayerData() {
        API.Client.shared.get(.prayerTime(
            city: CITY_PARAM,
            state: STATE_PARAM,
            country: COUNTRY_PARAM,
            method: METHOD_PARAM,
            iso8601: ISO8601_PARAM
        )) { [weak self] (result: Result<API.Types.Response.PrayerTimes, API.Types.Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.scrapeIqamaTimes { result in
                        switch result {
                        case .success(let text):
                            StringUtils.parseIqamaTimes(text)
                            let iqamaMap = StringUtils.iqamaTimesMap
                            
                            let currentDate = Date()
                            let prayerTimes = [
                                PrayerTime(
                                    type: .fajr,
                                    prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Fajr) ?? success.data.timings.Fajr,
                                    iqamaTime: iqamaMap[.fajr],
                                    dateTime: TimeUtils.dateFromTimeString(success.data.timings.Fajr, currentDate: currentDate)
                                ),
                                PrayerTime(
                                    type: .sunrise,
                                    prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Sunrise) ?? success.data.timings.Sunrise,
                                    iqamaTime: nil,
                                    dateTime: TimeUtils.dateFromTimeString(success.data.timings.Sunrise, currentDate: currentDate)
                                ),
                                PrayerTime(
                                    type: .dhuhr,
                                    prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Dhuhr) ?? success.data.timings.Dhuhr,
                                    iqamaTime: iqamaMap[.dhuhr],
                                    dateTime: TimeUtils.dateFromTimeString(success.data.timings.Dhuhr, currentDate: currentDate)
                                ),
                                PrayerTime(
                                    type: .asr,
                                    prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Asr) ?? success.data.timings.Asr,
                                    iqamaTime: iqamaMap[.asr],
                                    dateTime: TimeUtils.dateFromTimeString(success.data.timings.Asr, currentDate: currentDate)
                                ),
                                PrayerTime(
                                    type: .maghrib,
                                    prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Maghrib) ?? success.data.timings.Maghrib,
                                    iqamaTime: iqamaMap[.maghrib],
                                    dateTime: TimeUtils.dateFromTimeString(success.data.timings.Maghrib, currentDate: currentDate)
                                ),
                                PrayerTime(
                                    type: .isha,
                                    prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Isha) ?? success.data.timings.Isha,
                                    iqamaTime: iqamaMap[.isha],
                                    dateTime: TimeUtils.dateFromTimeString(success.data.timings.Isha, currentDate: currentDate)
                                )
                            ]
                            
                            let currentPrayerType = self?.determineCurrentPrayer(prayerTimes: prayerTimes)
                            
                            self?.state = HomeViewState(
                                prayerTimes: prayerTimes,
                                currentPrayerType: currentPrayerType,
                                loadingState: .success,
                                khutbah1Time: iqamaMap[.khutbah1] ?? "",
                                khutbah2Time: iqamaMap[.khutbah2] ?? ""
                            )
                            
                        case .failure(let error):
                            print("Error fetching web page: \(error.localizedDescription)")
                            self?.state = HomeViewState(
                                prayerTimes: [],
                                loadingState: .error
                            )
                        }
                    }
                    
                case .failure(_):
                    self?.state = HomeViewState(
                        prayerTimes: [],
                        loadingState: .error
                    )
                }
            }
        }
    }
    
    private func determineCurrentPrayer(prayerTimes: [PrayerTime]) -> PrayerType? {
            for (index, prayer) in prayerTimes.enumerated() {
                guard let prayerDate = prayer.dateTime else { continue }

                let nextPrayerDate = index == prayerTimes.count - 1
                    ? Calendar.current.date(byAdding: .day, value: 1, to: prayerTimes.first?.dateTime ?? Date())
                    : prayerTimes[index + 1].dateTime

                if let nextPrayerDate = nextPrayerDate, TimeUtils.isCurrentTime(between: prayerDate, and: nextPrayerDate) {
                    return prayer.type
                }
            }

            return nil
        }
}
