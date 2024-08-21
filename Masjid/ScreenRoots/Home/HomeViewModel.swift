//
//  HomeViewModel.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/23/23.
//

import Foundation

struct HomeViewState {
    let prayerTimes: [PrayerTime]
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
                    let prayerTimes = [
                        PrayerTime(type: .fajr, prayerTime: success.data.timings.Fajr, iqamaTime: nil),
                        PrayerTime(type: .sunrise, prayerTime: success.data.timings.Sunrise, iqamaTime: nil),
                        PrayerTime(type: .dhuhr, prayerTime: success.data.timings.Dhuhr, iqamaTime: nil),
                        PrayerTime(type: .asr, prayerTime: success.data.timings.Asr, iqamaTime: nil),
                        PrayerTime(type: .maghrib, prayerTime: success.data.timings.Maghrib, iqamaTime: nil),
                        PrayerTime(type: .isha, prayerTime: success.data.timings.Isha, iqamaTime: nil)
                    ]
                    
                    self?.state = HomeViewState(
                        prayerTimes: prayerTimes,
                        loadingState: LoadingState.success
                    )
                    
                case .failure(_):
                    self?.state = HomeViewState(
                        prayerTimes: [],
                        loadingState: LoadingState.error
                    )
                }
            }
        }
    }
}
