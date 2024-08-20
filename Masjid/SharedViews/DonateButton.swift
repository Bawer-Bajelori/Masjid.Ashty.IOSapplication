//
//  DonateButton.swift
//  Masjid
//
//  Created by Lawand Piromari on 3/22/24.
//

import SwiftUI

struct DonateButton: View {
    var body: some View {
        Button(action: {
            if let url = URL(string: DONATE_URL) {
                UIApplication.shared.open(url)
            }
        }) {
            Text("DONATE")
                .textTitle()
                .frame(maxWidth: .infinity)
                .padding()
                
        }
        .background(Color(CustomColor.PrimaryColor!))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(CustomColor.OnBackground!), lineWidth: 1.5)
        )
        .frame(maxWidth: .infinity)
    }
    
    //    var body: some View {
//        HStack {
//            Text(DONATE_BUTTON_TEXT)
//                .textTitle()
//                .background(Color(CustomColor.PrimaryColor!))
//                .foregroundColor(Color(CustomColor.OnSurface!))
//                .frame(maxWidth: .infinity)
//        }.contentShape(Rectangle()).onTapGesture {
//            if let url = URL(string: DONATE_URL) {
//                UIApplication.shared.open(url)
//            }
//        }
//        
//    }
}


struct DonateButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(CustomColor.PrimaryColor!).opacity(0.8) : Color(CustomColor.PrimaryColor!))
            .cornerRadius(15)
            .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(CustomColor.OnSurface!), lineWidth: 1.5)
            )
    }
}

#Preview {
    DonateButton()
}
