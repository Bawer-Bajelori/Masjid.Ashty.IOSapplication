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
            print("Processing word: \(word), nextWord: \(nextWord)") // Debugging
            
            switch word.lowercased() {
            case "fajir", "fajr":
                if validateIqamaTime(nextWord) {
                    print("Fajr time found: \(nextWord) AM") // Debugging
                    iqamaTimesMap[.fajr] = "\(nextWord) AM"
                }
            case "zhur", "dhuhr", "dhur", "zhuhr", "zuhr":
                if validateIqamaTime(nextWord) {
                    let time = nextWord[nextWord.index(nextWord.startIndex, offsetBy: 1)] == ":" ? "\(nextWord) PM" : "\(nextWord) AM"
                    print("Dhuhr time found: \(time)") // Debugging
                    iqamaTimesMap[.dhuhr] = time
                }
            case "asr":
                if validateIqamaTime(nextWord) {
                    print("Asr time found: \(nextWord) PM") // Debugging
                    iqamaTimesMap[.asr] = "\(nextWord) PM"
                }
            case "maghrib", "maghreb":
                if validateIqamaTime(nextWord) || nextWord.lowercased() == "sunset" {
                    let maghribTime = nextWord.lowercased() == "sunset" ? "Sunset" : nextWord
                    print("Maghrib time found: \(maghribTime)") // Debugging
                    iqamaTimesMap[.maghrib] = maghribTime.capitalized
                }
            case "isha", "isha'a", "esha", "esha'a":
                if validateIqamaTime(nextWord) {
                    print("Isha time found: \(nextWord) PM") // Debugging
                    iqamaTimesMap[.isha] = "\(nextWord) PM"
                }
            case "khutbah", "khutbah#", "khutba#", "khutba":
                addKhutbahTime(words, index: index)
                print("Khutbah times found: \(KhutbahTimesView.self)")
            default:
                print("Word not matched: \(word)") // Debugging 
                break
            }
        }
            let khutbahRegex = try! NSRegularExpression(pattern: "KHUTBAH\\s*#\\s*([12])\\s*at\\s*(\\d{1,2}:\\d{2})", options: [.caseInsensitive])
            let matches = khutbahRegex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
            
            for match in matches {
                let khutbahNum = String(text[Range(match.range(at: 1), in: text)!])
                let time = String(text[Range(match.range(at: 2), in: text)!])
                
                if khutbahNum == "1" {
                    iqamaTimesMap[.khutbah1] = time
                    print("Khutbah 1 time found: \(time)") // Debugging line
                } else if khutbahNum == "2" {
                    iqamaTimesMap[.khutbah2] = time
                    print("Khutbah 2 time found: \(time)") // Debugging line
                }
            }
            
            return iqamaTimesMap
        }
    
    
    private static func addKhutbahTime(_ words: [String], index: Int) {
        var khutbahNum = ""
        
        // Check if the word contains a # or if the next word does
        if words[index].trimmingCharacters(in: .whitespacesAndNewlines).contains("#") {
            khutbahNum = words[index + 1].trimmingCharacters(in: .whitespacesAndNewlines)
        } else if words[index + 1].trimmingCharacters(in: .whitespacesAndNewlines) == "#" {
            khutbahNum = words[index + 2].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        // Ensure the khutbahNum is either "1" or "2"
        if khutbahNum != "1" && khutbahNum != "2" {
            print("Skipping: Not a valid Khutbah number \(khutbahNum)") // Debugging
            return
        }
        
        // searching for the time
        for i in index..<words.count {
            let cleanWord = words[i].trimmingCharacters(in: .whitespacesAndNewlines)
            if validateIqamaTime(cleanWord) {
                switch khutbahNum {
                case "1":
                    iqamaTimesMap[.khutbah1] = cleanWord
                    print("Khutbah 1 time found: \(cleanWord)") // Debugging
                case "2":
                    iqamaTimesMap[.khutbah2] = cleanWord
                    print("Khutbah 2 time found: \(cleanWord)") // Debugging
                default:
                    break
                }
                break
            }
        }
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
}
