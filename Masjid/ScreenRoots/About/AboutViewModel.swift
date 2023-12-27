import SwiftUI


enum SocialMediaType: String {
    case facebook = "Facebook"
    case youtube = "YouTube"

    var iconName: String {
        switch self {
        case .facebook:
            return "Facebook-icon"
        case .youtube:
            return "Youtube-icon"
        }
    }
}

struct AboutViewModel {
    var state: AboutViewState

    init() {
        state = createState()
    }
}

struct AboutViewState {
    var title: String
    var subtitle: String
    var infoItemList: [InfoItem]
    var socialMediaList: [SocialMediaItem]
    var donationText: String
    var donationLink: String
}


enum InfoItemType {
    case address, website, email, phone
}

struct InfoItem: Identifiable {
    let id = UUID()
    var type: InfoItemType
    var displayText: String
}

struct SocialMediaItem: Identifiable {
    let id = UUID()
    var type: SocialMediaType
    var URL: String
}

func createState() -> AboutViewState {
    return AboutViewState(
        title: "Kurdish Community Islamic Center",
        subtitle: "For more information, please contact us at:",
        infoItemList: [
            InfoItem(type: .address, displayText: "1357 Broadway, El Cajon, California 92021, United States"),
            InfoItem(type: .website, displayText: "masjidashty.com"),
            InfoItem(type: .email, displayText: "masjidashty2010@hotmail.com"),
            InfoItem(type: .phone, displayText: "(619)442-4435")
        ],
        socialMediaList: [
            SocialMediaItem(type: .youtube, URL: "https://www.youtube.com/@AlSalamAshty"),
            SocialMediaItem(type: .facebook, URL: "https://www.facebook.com/people/Mizgaft-Ashty/100068623803799/")
        ],
        donationText:"Dear brother and sister you can make your donation online for \n\n 1- Masjid Expansion \n\n 2- Masjid Operation \n\n 3- Needy \n\n 4- Zakat Al Fitr\n\n 5-Zakat Al Mal",
        donationLink: "https://goodbricksapp.com/masjidashty.com/donate"
        
    )
}
