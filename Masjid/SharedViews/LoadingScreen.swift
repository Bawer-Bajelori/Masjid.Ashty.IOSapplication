//
//  LoadingScreen.swift
//  Masjid
//
//  Created by Lawand Piromari on 3/22/24.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack {
            Color(CustomColor.BackgroundColor!)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color(CustomColor.PrimaryColor!)))
                .scaleEffect(2, anchor: .center)
        }
    }
}

#Preview {
    LoadingScreen()
}
