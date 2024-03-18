//
//  SwiftUIView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 3/1/23.
//

import SwiftUI


struct ServicesView: View {
    @ObservedObject var viewModel: ServicesViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                Text(viewModel.state.servicesTitle)
                    .textTitle()
                    
                Spacer().frame(height: 16)
                    
                Text(viewModel.state.sevicesScreenDescription)
                    .textBodyPrimary(textAlignment: .center)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8 ))
                    
                ForEach(viewModel.state.services, id: \.title) { service in
                    ExpandableCard(service: service)
                }
            }
        }
        .background(Color(CustomColor.BackgroundColor! ))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
    }
}


struct RoundedBorderShape: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = RoundedRectangle(cornerRadius: cornerRadius).path(in: rect)
        return path
    }
}


struct ExpandableCard: View {
    var service: Service

    @State private var expand = false

    var body: some View {
        VStack {
            HStack {
                Text(service.title)
                    .textTitle()
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                Spacer()

                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(expand ? 180 : 0))
                    .padding()
            }

            if expand {
                Text(service.text)
                    .textBodyPrimary()
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            }
        }
        .background(Color(CustomColor.BackgroundColor! ))
        .cornerRadius(8)
        .overlay(
                RoundedBorderShape(cornerRadius: 8)
                    .stroke(Color(CustomColor.PrimaryColor!), lineWidth: expand ? 3 :1.5)
                )
        .padding(8)
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
        }
    }
}
