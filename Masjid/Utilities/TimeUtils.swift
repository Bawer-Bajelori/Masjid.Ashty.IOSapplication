import Foundation

class TimeUtils {
    
    static func convertTo12HourFormat(_ time: String) -> String? {
        let dateFormatter = DateFormatter()
        
        // Input format (24-hour)
        dateFormatter.dateFormat = "HH:mm"
        
        // Convert the string time to Date
        guard let date = dateFormatter.date(from: time) else {
            return nil
        }
        
        // Output format (12-hour with AM/PM)
        dateFormatter.dateFormat = "h:mm a"
        
        // Convert Date back to string in 12-hour format
        return dateFormatter.string(from: date)
    }
}
