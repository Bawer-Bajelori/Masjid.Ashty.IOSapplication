//
//  IconFormatModifiers.swift
//  Masjid
//
//  Created by Lawand Piromari on 4/6/24.
//

import SwiftUI


extension Image {
    func iconFormat() -> some View {
        self
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(Color(CustomColor.OnBackground!))
    }
}

