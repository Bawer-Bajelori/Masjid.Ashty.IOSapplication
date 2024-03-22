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
            Text(DONATE_BUTTON_TEXT)
                .textTitle()
                .background(Color(CustomColor.PrimaryColor!))
                .foregroundColor(Color(CustomColor.OnSurface!))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(CustomColor.OnSurface!), lineWidth: 1.5)
                )
        }
    }
}

#Preview {
    DonateButton()
}
