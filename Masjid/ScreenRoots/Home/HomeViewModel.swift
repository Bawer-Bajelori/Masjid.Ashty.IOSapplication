//
//  HomeViewModel.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/23/23.
//

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
    /* to use, you could do: let prayer = PrayerType.Fajr
       then print(prayer.prayername) would give "Fajr"
    */
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
        // Validate the URL
        guard let url = URL(string: IQAMA_TIME_URL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        // Asynchronously fetch the webpage content using URLSession
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle network error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure we have data and can decode it as a UTF-8 string
            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "Invalid Data", code: 2, userInfo: nil)))
                return
            }
            
            do {
                // Parse the HTML using SwiftSoup
                let document = try SwiftSoup.parse(html)
                
                // Extract all text from the document
                let bodyText = try document.text()
                
                // Return the extracted text via the completion handler
                completion(.success(bodyText))
                
            } catch {
                // Handle parsing errors
                completion(.failure(error))
            }
        }
        
        // Start the network task
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
                switch result{
                case .success(let success):
                    self?.scrapeIqamaTimes{ result in
                        switch result{
                        case .success(let text):
                            StringUtils.parseIqamaTimes(text)
                            let iqamaMap = StringUtils.iqamaTimesMap
                            
                            
                            let prayerTimes = [
                                PrayerTime(type: .fajr, prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Fajr) ?? success.data.timings.Fajr, iqamaTime: iqamaMap[.fajr]),
                                PrayerTime(type: .sunrise, prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Sunrise) ?? success.data.timings.Sunrise, iqamaTime: nil),
                                PrayerTime(type: .dhuhr, prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Dhuhr) ?? success.data.timings.Dhuhr, iqamaTime: iqamaMap[.dhuhr]),
                                PrayerTime(type: .asr, prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Asr) ?? success.data.timings.Asr, iqamaTime: iqamaMap[.asr]),
                                PrayerTime(type: .maghrib, prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Maghrib) ?? success.data.timings.Maghrib, iqamaTime: iqamaMap[.maghrib]),
                                PrayerTime(type: .isha, prayerTime: TimeUtils.convertTo12HourFormat(success.data.timings.Isha) ?? success.data.timings.Isha, iqamaTime: iqamaMap[.isha])
                            ]
                            let currentPrayerType = self?.determineCurrentPrayer(prayerTimes: prayerTimes)

                            
                            self?.state = HomeViewState(
                                
                                prayerTimes: prayerTimes,
                                currentPrayerType: currentPrayerType,
                                loadingState: LoadingState.success,
                                khutbah1Time: iqamaMap[.khutbah1] ?? "",
                                khutbah2Time: iqamaMap[.khutbah2] ?? ""
                            )
                            
                            
                        case .failure(let error):
                            print("error fetching web page \(error.localizedDescription)")
                            
                        }
                    }
                    
                case .failure(_):
                    self?.state = HomeViewState(
                        prayerTimes: [],
                        loadingState: LoadingState.error
                    )
                    
                    
                    
                }
            }
        }
    }
    private func determineCurrentPrayer(prayerTimes: [PrayerTime]) -> PrayerType? {
           let currentTime = Date()
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "h:mm a"

           for (index, prayer) in prayerTimes.enumerated() {
               if let prayerDate = dateFormatter.date(from: prayer.prayerTime),
                  index < prayerTimes.count - 1,
                  let nextPrayerDate = dateFormatter.date(from: prayerTimes[index + 1].prayerTime) {
                   
                   if currentTime >= prayerDate && currentTime < nextPrayerDate {
                       return prayer.type
                   }
               }
           }
           
           
           if let lastPrayer = prayerTimes.last,
              let lastPrayerDate = dateFormatter.date(from: lastPrayer.prayerTime),
              currentTime >= lastPrayerDate {
               return lastPrayer.type
           }
           
           return nil
       }
   }

