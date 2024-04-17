//
//  ButtonWithIconAndText.swift
//  Masjid
//
//  Created by Lawand Piromari on 3/22/24.
//

import SwiftUI
import Foundation

struct ButtonWithIconAndText: View {
    var text: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .iconFormat()
                Text(text)
                    .textHyperLink().multilineTextAlignment(TextAlignment.leading)
            }
            .padding()
            .background(Color(CustomColor.BackgroundColor!)) // background color
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1.5)
            )
        }
    }
}
