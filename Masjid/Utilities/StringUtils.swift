//
//  StringUtils.swift
//  Masjid
//
//  Created by Bawer Bajelori on 8/21/24.
//

import Foundation


class StringUtils {
    
    public static var iqamaTimesMap: [PrayerType: String] = [:]
    
    public static func parseIqamaTimes(_ text: String) -> [PrayerType: String] {
        let words = text.split(separator: " ").map { String($0) }
        
        for (index, word) in words.enumerated() {
            let nextWord = index < words.count - 1 ? words[index + 1].trimmingCharacters(in: .whitespacesAndNewlines) : ""
            print("Processing word: \(word), nextWord: \(nextWord)") // Debugging line
            
            switch word.lowercased() {
            case "fajir", "fajr":
                if validateIqamaTime(nextWord) {
                    print("Fajr time found: \(nextWord) AM") // Debugging line
                    iqamaTimesMap[.fajr] = "\(nextWord) AM"
                }
            case "zhur", "dhuhr", "dhur", "zhuhr", "zuhr":
                if validateIqamaTime(nextWord) {
                    let time = nextWord[nextWord.index(nextWord.startIndex, offsetBy: 1)] == ":" ? "\(nextWord) PM" : "\(nextWord) AM"
                    print("Dhuhr time found: \(time)") // Debugging line
                    iqamaTimesMap[.dhuhr] = time
                }
            case "asr":
                if validateIqamaTime(nextWord) {
                    print("Asr time found: \(nextWord) PM") // Debugging line
                    iqamaTimesMap[.asr] = "\(nextWord) PM"
                }
            case "maghrib", "maghreb":
                if validateIqamaTime(nextWord) || nextWord.lowercased() == "sunset" {
                    print("Maghrib time found: \(nextWord)") // Debugging line
                    iqamaTimesMap[.maghrib] = nextWord
                }
            case "isha", "isha'a", "esha", "esha'a":
                if validateIqamaTime(nextWord) {
                    print("Isha time found: \(nextWord) PM") // Debugging line
                    iqamaTimesMap[.isha] = "\(nextWord) PM"
                }
            case "khutba", "khutbah", "khutbah#", "khutba#":
                addKhutbahTime(words, index: index)
            default:
                print("Word not matched: \(word)") // Debugging line
                break
            }
        }
        
        return iqamaTimesMap
    }

    
    static func validateIqamaTime(_ time: String) -> Bool {
        let size = time.count
        if size != 4 && size != 5 {
            return false
        }
        
        if size == 4 {
            for (index, c) in time.enumerated() {
                switch index {
                case 0, 2, 3:
                    if !c.isNumber { return false }
                case 1:
                    if c != ":" { return false }
                default:
                    break
                }
            }
        } else if size == 5 {
            for (index, c) in time.enumerated() {
                switch index {
                case 0, 1, 3, 4:
                    if !c.isNumber { return false }
                case 2:
                    if c != ":" { return false }
                default:
                    break
                }
            }
        }
        
        return true
    }
    
    private static func addKhutbahTime(_ words: [String], index: Int) {
        var khutbahNum = ""
        
        if words[index].last == "#" {
            if words[index + 1] != "1" && words[index + 1] != "2" { return }
            khutbahNum = words[index + 1]
            for i in index + 2..<words.count {
                if validateIqamaTime(words[i]) {
                    switch khutbahNum {
                    case "1":
                        iqamaTimesMap[.khutbah1] = words[i]
                    case "2":
                        iqamaTimesMap[.khutbah2] = words[i]
                    default:
                        break
                    }
                    break
                }
            }
        } else {
            if words[index + 1] != "#" { return }
            if words[index + 2] != "1" && words[index + 2] != "2" { return }
            khutbahNum = words[index + 2]
            for i in index + 3..<words.count {
                if validateIqamaTime(words[i]) {
                    switch khutbahNum {
                    case "1":
                        iqamaTimesMap[.khutbah1] = words[i]
                    case "2":
                        iqamaTimesMap[.khutbah2] = words[i]
                    default:
                        break
                    }
                    break
                }
            }
        }
    }
}
