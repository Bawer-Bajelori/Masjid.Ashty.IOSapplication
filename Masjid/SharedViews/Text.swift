//
//  Text.swift
//  Masjid
//
//  Created by Lawand Piromari on 11/3/23.
//

import SwiftUI

var defaultTextColor: Color = Color(CustomColor.OnBackground!)

// Create a custom view modifier for Text with body1 style
struct TextBodyPrimary: ViewModifier {
    
    var fontWeight: Font.Weight
    var textAlignment: TextAlignment
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(defaultTextColor)
            .fontWeight(.regular)
            .multilineTextAlignment(textAlignment)
            .lineSpacing(2) // Adjust line spacing as needed
    }
}

extension View {
    func textBodyPrimary(fontWeight: Font.Weight = .regular, textAlignment: TextAlignment = .leading) -> some View {
        modifier(TextBodyPrimary(fontWeight: fontWeight, textAlignment: textAlignment))
    }
}

// Create a custom view modifier for hyperlinks
struct TextHyperLink: ViewModifier {
    
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(defaultTextColor)
            .underline() // Add underline for hyperlinks
    }
}

extension View {
    func textHyperLink() -> some View {
        modifier(TextHyperLink())
    }
}

// Create a custom view modifier for text titles
struct TextTitle: ViewModifier {
    
    var textAlignment: TextAlignment
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(textColor)
            .fontWeight(.semibold)
            .multilineTextAlignment(textAlignment)
            .lineSpacing(4) // Adjust line spacing as needed
    }
}

extension View {
    func textTitle(textAlignment: TextAlignment = .center, textColor: Color = Color(CustomColor.OnBackground!)) -> some View {
        modifier(TextTitle(textAlignment: textAlignment, textColor: textColor))
    }
}

// Create a custom view modifier for text in a calendar table
struct TextCalendarTable: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .regular, design: .default))
            .foregroundColor(defaultTextColor)
    }
}

extension View {
    func textCalendarTable() -> some View {
        modifier(TextCalendarTable())
    }
}



