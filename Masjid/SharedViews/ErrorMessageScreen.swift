//
//  ErrorMessageScreen.swift
//  Masjid
//
//  Created by Lawand Piromari on 3/22/24.
//

import SwiftUI

struct ErrorMessageScreen: View {
    var text: String
    var buttonText: String
    var onClick: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Text(text)
                    .textTitle()
                
                Button(action: onClick) {
                    Text(buttonText)
                        .textTitle()
                        .padding()
                        .background(Color(CustomColor.PrimaryColor!))
                        .cornerRadius(5)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            .padding()
            .background(Color(CustomColor.BackgroundColor!))
            .cornerRadius(10)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(CustomColor.PrimaryColor!), lineWidth: 1.5)
            )
            .padding()
            Spacer()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ErrorMessageScreen(
        text: HOME_ERROR_MESSAGE,
        buttonText: HOME_ERROR_BUTTON_MESSAGE,
        onClick: {}
    )
}
