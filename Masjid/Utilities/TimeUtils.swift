import Foundation

class TimeUtils {

    /// Converts a 24-hour time string to a 12-hour time string with AM/PM.
    static func convertTo12HourFormat(_ time: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current

        guard let date = dateFormatter.date(from: time) else {
            return nil
        }

        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }

    /// Combines a time string with the current date to create a full `Date` object.
    static func dateFromTimeString(_ time: String, currentDate: Date) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current

        guard let timeDate = dateFormatter.date(from: time) else {
            return nil
        }

        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)
        components.hour = timeComponents.hour
        components.minute = timeComponents.minute
        components.second = 0

        return calendar.date(from: components)
    }

    /// Checks if the current time is between two given `Date` objects.
    static func isCurrentTime(between startTime: Date, and endTime: Date) -> Bool {
        let currentTime = Date()
        return currentTime >= startTime && currentTime < endTime
    }
}
