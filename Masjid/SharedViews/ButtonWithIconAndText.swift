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
    //var imageColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                    //.foregroundColor(imageColor)
                Text(text)
                    .textHyperLink()
            }
            .padding()
            .background() // background color
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1.5)
            )
        }
    }
}
