//
//  AboutVIewModel.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/20/23.
//

import SwiftUI

struct AboutViewModel {
    var state: AboutViewState
    
    init(){
     state = createState()
    }
    
}

struct AboutViewState{
    var title: String
    
    var subtitle: String
    
    var infoItemList: [InfoItem]
    
    var socialMediaList: [SocialMedia]
    
    var donationText: String
}
struct InfoItem: Identifiable {
    let id = UUID()
    
    var icon: Int
    
    var data: String
    
    var displayText: String
        
}

struct SocialMedia{
    var icon: Int
    
    var URL: String
    
    
}

func createState()-> AboutViewState{
    return AboutViewState(
        title: "Kurdish Community Islamic Center",
        
        subtitle:"For more information, please contact us at:",
        
        infoItemList: [
            InfoItem(icon: 0, data: "", displayText: "1357 Broadway, El Cajon, California 92021, United States"),
            InfoItem(icon: 0, data: "", displayText: "masjidashty.com"),
            InfoItem(icon: 0, data: "", displayText: "masjidashty2010@hotmail.com"),
            InfoItem(icon: 0, data: "", displayText: "(619)442-4435")
        ],
        
        socialMediaList: [
            SocialMedia(icon: 0, URL: ""),
                
            SocialMedia(icon: 0, URL: "https://www.youtube.com/@AlSalamAshty")
                
        ],
        donationText: "" )
    
}
