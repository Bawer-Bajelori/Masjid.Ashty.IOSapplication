//
//  IconButton.swift
//  Masjid
//
//  Created by Lawand Piromari on 3/22/24.
//

import SwiftUI

struct IconButton: View {
    var imageName: String
    var imageColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .foregroundColor(imageColor)
        }
    }
}
