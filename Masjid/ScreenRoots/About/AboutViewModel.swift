import SwiftUI
import Foundation

struct AboutViewState {
    let aboutTitle: String
    let socialMediaTitle: String
    let donateDescription: String
    let aboutScreenDescription: String
    let socialMedia: [SocialMedia]
    let infoItems: [InfoItem]
}

struct SocialMedia {
    let iconID: String
    let URL: String
    let tint: Color
}

struct InfoItem: Identifiable{
    let id = UUID()
    let iconID: String
    let text: String
    let URL: String
    let data: String
    let type: InfoItemType
}

enum InfoItemType {
    case ADDRESS
    case WEBSITE
    case EMAIL
    case PHONE
}

class AboutViewModel: ObservableObject {
    @Published var state: AboutViewState = createAboutViewState()
    
    func onEmailTapped(email: String) {
        
        print("Lawand " + email)
        
        if let url = URL(string: "mailto:\(email)") {
            print("Lawand Are we in here")
            UIApplication.shared.open(url)
        }
    }
    
    func onPhoneNumberTapped(number: String) {
        
        print("Lawand " + number)
        
        guard let url = URL(string: "telprompt://\(number)") else { return }
        UIApplication.shared.open(url)
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            print("Lawand Are we in here")
            print(url)
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
        
    func onWebLinkTapped(urlString: String) {
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func onInfoItemTapped(infoItem: InfoItem) {
        let type = infoItem.type
        let url = infoItem.URL
        let data = infoItem.data
        
        switch type {
        case InfoItemType.EMAIL:
            onEmailTapped(email: data)
        case InfoItemType.PHONE:
            onPhoneNumberTapped(number: data)
        default:
            onWebLinkTapped(urlString: url)
        }
    }
}

func createAboutViewState() -> AboutViewState {
    return AboutViewState(
        aboutTitle: "KURDISH COMMUNITY ISLAMIC CENTER",
        socialMediaTitle: "Socials",
        donateDescription: "Dear brothers and sisters you can make your donation online for: \n" +
        "\n" +
        "1- Masjid Expansion\n" +
        "\n" +
        "2- Masjid Operation\n" +
        "\n" +
        "3- The Needy\n" +
        "\n" +
        "4- Zakat Al Fitr\n" +
        "\n" +
        "5- Zakat Al Mal",
        aboutScreenDescription: "For more Information about events, services, and more,\n" + "Please Contact Us at:",
        socialMedia: [
            SocialMedia(iconID: "youtube_logo", URL: YOUTUBE_URL, tint: Color(CustomColor.YoutubeRed!)),
            SocialMedia(iconID: "facebook_logo", URL: FACEBOOK_URL, tint: Color(CustomColor.FacebookBlue!))
        ],
        infoItems: [
            InfoItem(
                iconID: "baseline_address_on_24",
                text: ADDRESS_TEXT,
                URL: GOOGLE_MAPS_ADDRESS_URL,
                data: "",
                type: .ADDRESS
            ),
            InfoItem(
                iconID: "baseline_website_24",
                text: WEBSITE_TEXT,
                URL: WEBSITE_URL,
                data: "",
                type: .WEBSITE
            ),
            InfoItem(
                iconID: "baseline_email_24",
                text: EMAIL_TEXT,
                URL: "",
                data: EMAIL_DATA,
                type: .EMAIL
            ),
            InfoItem(
                iconID: "baseline_phone_24",
                text: PHONE_TEXT,
                URL: "",
                data: PHONE_DATA,
                type: .PHONE
            )
        ]
    )
}
