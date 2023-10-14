//
//  APITypes.swift
//  Masjid
//
//  Created by Bawer Bajelori on 3/29/23.
//

import Foundation


extension API{
    
    enum Types{
        
        enum Response{
            
            struct PrayerTimes: Decodable {
                var data: Data
                struct Data: Decodable{
                    var timings: Timings
                    
                }
                
                struct Timings: Decodable{
                    var Fajr: String
                    var Sunrise: String
                    var Dhuhr: String
                    var Asr: String
                    var Maghrib: String
                    var Isha: String
                }
                                
                
            }
            
            struct CalendarTimes: Decodable{
                var data: [Data]
                struct Data: Decodable{
                    var timings: Timings
                
            }
                struct Timings: Decodable{
                    var Fajr: String
                    var Sunrise: String
                    var Dhuhr: String
                    var Asr: String
                    var Maghrib: String
                    var Isha: String
                    
                    struct Date{
                        var gregorian: Gregorian
                        var hijri: Hijri
                    }
                }
                struct Gregorian{
                    var day: String
                    var weekday: Weekday
                    var month: Month
                    var year: String
                    var hijri: Hijri
                }
                struct Hijri{
                    var day: String
                    var month: Month
                    var year: String
                }
                struct Month{
                    var number: Int
                    var en: String
                }
                struct Weekday{
                    var en: String
                }
                
        }
            struct HijriCalendarTimes: Decodable {
                var data: [Data]
                struct Data: Decodable{
                    var timings: Timings
                }
                struct Timings: Decodable{
                    var Fajr: String
                    var Sunrise: String
                    var Dhuhr: String
                    var Asr: String
                    var Maghrib: String
                    var Isha: String
                }
                struct Date{
                    var gregorian: Gregorian
                    var hijri: Hijri
                }
                struct Gregorian{
                    var day: String
                    var weekday: Weekday
                    var month: Month
                    var year: String
                    var hijri: Hijri
                }
                struct Hijri{
                    var day: String
                    var month: Month
                    var year: String
                }
                struct Month{
                    var number: Int
                    var en: String
                }
                struct Weekday{
                    var en: String
                }
            }
            }
        
            
            
        
        enum Request{
            struct Empty: Encodable{
                
            }
            
        }
        
        enum Error: LocalizedError{
            case generic(reason: String)
            case `internal`(reason: String)
            var errorDescription: String? {
                switch self{
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "internal error: \(reason)"
                }
            }
            
            
        }
        
        enum EndPoint{
            case prayerTime(
                city: String,
                state: String,
                country: String,
                method: String,
                iso8601: String
            )
            case calendarTime(
                city: String,
                state: String,
                country: String,
                method: String,
                iso8601: String,
                year: String,
                month: String
            )
            case hijriCalendarTime(
                city: String,
                state: String,
                country: String,
                method: String,
                iso8601: String,
                year: String,
                month: String
            )
            var url: URL {
                var compenents = URLComponents()
                compenents.host = "api.aladhan.com"
                compenents.scheme = "https"
                switch self{
                
                case .prayerTime(let city, let state, let country, let method, let iso8601):
                    compenents.path = "/v1/timingsByCity"
                    compenents.queryItems = [
                        URLQueryItem(name: "city", value: city),
                        URLQueryItem(name: "state", value: state),
                        URLQueryItem(name: "country", value: country),
                        URLQueryItem(name: "method", value: method),
                        URLQueryItem(name: "iso8601", value: iso8601)
                        ]
                case .calendarTime(let city, let state, let country, let method , let iso8601, let year,let month):
                    compenents.path = "/v1/calendarByCity"
                    compenents.queryItems = [
                        URLQueryItem(name: "city", value: city),
                        URLQueryItem(name: "state", value: state),
                        URLQueryItem(name: "country", value: country),
                        URLQueryItem(name: "method", value: method),
                        URLQueryItem(name: "iso8601", value: iso8601),
                        URLQueryItem(name: "year", value: year),
                        URLQueryItem(name: "month", value: month)
                    ]
                
                
                case .hijriCalendarTime(let city, let state, let country, let method , let iso8601, let year,let month):
                    compenents.path = "/v1/hijriCalendarByCity"
                    compenents.queryItems = [
                        URLQueryItem(name: "city", value: city),
                        URLQueryItem(name: "state", value: state),
                        URLQueryItem(name: "country", value: country),
                        URLQueryItem(name: "method", value: method),
                        URLQueryItem(name: "iso8601", value: iso8601),
                        URLQueryItem(name: "year", value: year),
                        URLQueryItem(name: "month", value: month)
                    ]
                
                }
                return compenents.url!
            }
        }
        enum Method: String{
            case get
            case post
        }
    }
    
}

