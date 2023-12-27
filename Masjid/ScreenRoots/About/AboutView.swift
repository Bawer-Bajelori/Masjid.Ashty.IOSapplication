//
//  AboutView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/18/23.
//

import SwiftUI

struct AboutView : View{
    var viewModel: AboutViewModel
    var body: some View{
        
        ScrollView{
            ZStack{
                VStack(spacing: 20){
                    
                    
                    
                    Text(viewModel.state.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                    Spacer()
                    
                    
                    Text(viewModel.state.subtitle)
                        .padding()
                        .font(.headline)
                    
                    
                    
                    ForEach(viewModel.state.infoItemList){ i in
                        Button(action: {
                            handleInfoItemTap(item: i)
                        })
                        {
                            HStack{
                                Text(i.displayText)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                
                            }
                        }
                        .foregroundColor(Color.blue)
                    }
                    HStack(spacing: 40){
                        ForEach(viewModel.state.socialMediaList){ socialMediaItem in
                            Button(action: {
                                openSocialMediaLink(socialMediaItem)
                            }){
                                Image(socialMediaItem.type.iconName)
                            
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                               
                                }
                        }
                    }
                    Text(viewModel.state.donationText)
                        .padding()
                        .font(.headline)
                    Button(action: {
                        if let url = URL(string: viewModel.state.donationLink){
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Donate")
                            .padding()
                            .frame(maxWidth:.infinity)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
            
               
                .background(Color.init(uiColor: CustomColor.customBackgroundColor ?? .white))
            }
        }
    }
    func handleInfoItemTap(item:InfoItem){
        switch item.type {
        case .address:
            if let url = URL(string:"http://maps.apple.com/?address=\(item.displayText.replacingOccurrences(of: " ", with: "+"))"){
                UIApplication.shared.open(url)
            }
        case.website:
            if let url = URL(string:"http://\(item.displayText)"){
                UIApplication.shared.open(url)
            }
        case.email:
            if let url = URL(string: "mailto:\(item.displayText)"){
                UIApplication.shared.open(url)
            }
        case.phone:
            if let url = URL(string:  "tel://\(item.displayText.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: ""))") {
                UIApplication.shared.open(url)
            }
            
        }
    }
        func openSocialMediaLink(_ socialMediaItem: SocialMediaItem){
            guard let url = URL(string: socialMediaItem.URL) else {return}
            UIApplication.shared.open(url)
        
        
    }
}
        struct AboutView_Previews: PreviewProvider {
            static var previews: some View {
                AboutView(viewModel: AboutViewModel())
                
            
    }
}

