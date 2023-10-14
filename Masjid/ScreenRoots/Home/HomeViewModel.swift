//
//  HomeViewModel.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/23/23.
//

import Foundation
struct PrayerTime: Identifiable {
    let id = UUID()
    
    let name : String
    let prayerTime: String
}
enum LoadingState {
    case loading
    case error(String)
    case success([PrayerTime])
    
    var prayerTimes: [PrayerTime]? {
        switch self {
        case .success(let prayerTimes):
            return prayerTimes
        default:
            return nil
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .error(let message):
            return message
        default:
            return nil
        }
    }
}

class HomeViewModel: ObservableObject {
    @Published var loadingState = LoadingState.loading
    
    func errorButtonOnClick() {
        fetchPrayerData()
    }
    
     

     func fetchPrayerData() {
        API.Client.shared.get(.prayerTime(city: "El Cajon", state: "California", country: "US", method: "2", iso8601: "false")) {(result: Result<API.Types.Response.PrayerTimes, API.Types.Error>) in
            DispatchQueue.main.async {
                switch result{
                case .success(let success):
                    self.loadingState = LoadingState.success(
                        [
                            PrayerTime(name: "Fajr", prayerTime: success.data.timings.Fajr),
                            PrayerTime(name: "Sunrise", prayerTime: success.data.timings.Sunrise),
                            PrayerTime(name: "Dhuhr", prayerTime: success.data.timings.Dhuhr),
                            PrayerTime(name: "Asr", prayerTime: success.data.timings.Asr),
                            PrayerTime(name: "Maghrib", prayerTime: success.data.timings.Maghrib),
                            PrayerTime(name: "Isha", prayerTime: success.data.timings.Isha)
                        ])
                            
                    print("bawer \(success.data.timings.Fajr)")
                    
                    //self.objectWillChange.send()
                case .failure(let failure):
                    self.loadingState = LoadingState.error(failure.errorDescription!)
                }
            
            }
            
        }
    }
    
    func provideFactory() -> HomeViewModel {
        return HomeViewModel()
    }
}

struct PrayerTimeResponse: Decodable {
    let data: PrayerTimeData
}

struct PrayerTimeData: Decodable {
    let timings: PrayerTimeTimings
}

struct PrayerTimeTimings: Decodable {
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
}
