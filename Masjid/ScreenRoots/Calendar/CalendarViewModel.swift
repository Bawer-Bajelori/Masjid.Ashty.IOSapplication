//
//  CalendarViewModel.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/23/23.
//

import SwiftUI
import Foundation
import Combine

struct Month {
    var name: String
    var number: Int
}

struct CalendarPrayerTime {
    var name: String
    var prayerTime: String
}

struct Day: Identifiable {
   var id = UUID()
    //var weekDayCellText: String
    var prayerTimes: [CalendarPrayerTime]
    //var month: Month
   // var year: String
   // var currentDayIndex: Int
}

enum CalendarType {
    case gregorian
    case hijri
}

struct CalendarKey {
    var month: Int
    var year: Int
    var type: CalendarType
}

struct CalendarViewState {
    var days: [Day] = []
    var loadingState: LoadingState = .loading
    var errorMessage: String = "Error\nCheck Network Connection"
    var errorButtonMessage: String = "Try Again"
    var type: CalendarType = .gregorian
    var calendarTitle: String = ""
    enum LoadingState{
        case success
        case error(errorMessage: String)
        case loading
    }
    var buttonText: String {
        switch type {
        case .gregorian:
            return "Hijri"
        case .hijri:
            return "Gregorian"
        }
    }
}
class CalenderViewModel: ObservableObject{
    @Published var state: CalendarViewState
    init() {
        state = CalendarViewState()
    }
    
     func fetchCalendarTimes() {
        API.Client.shared.get(.calendarTime(city: "El Cajon", state: "California", country: "US", method: "2", iso8601: "false", year: "2023", month: "3"))
        {(result: Result<API.Types.Response.CalendarTimes,API.Types.Error>) in
            DispatchQueue.main.async {
                switch result{
                case .success(let success):
                    self.state.loadingState = CalendarViewState.LoadingState.success
                    self.state.days = self.mapResponseData(response: success)
                case .failure(let failure):
                    self.state.loadingState = CalendarViewState.LoadingState.error(errorMessage: failure.errorDescription!)
                    
                }
            }
        }
    }
    private func mapResponseData(response: API.Types.Response.CalendarTimes)-> [Day]{
        return response.data.map{ data in
            Day(
                 prayerTimes:
                    [CalendarPrayerTime(name: "Fajr", prayerTime: data.timings.Fajr),
                     CalendarPrayerTime(name: "Dhuhr", prayerTime: data.timings.Dhuhr),
                     CalendarPrayerTime(name: "Asr", prayerTime: data.timings.Asr),
                     CalendarPrayerTime(name: "Maghrib", prayerTime: data.timings.Maghrib),
                     CalendarPrayerTime(name: "Isha", prayerTime: data.timings.Isha),
                    ]
            )
        
            
            
        }
        
    }
}
    


