//
//  ContentView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/12/23.
//
import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().backgroundColor = CustomColor.PrimaryColor
    }
    
    @State var size: CGSize = .zero
    
    var body: some View {
        
        
        TabView{
                HomeView(viewModel: HomeViewModel())
                    .tabItem{
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
            CalendarView(viewModel: CalenderViewModel())
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                ServicesView(viewModel: ServicesViewModel())
                    .tabItem{
                        Image("baseline_services_icon24")
                            .renderingMode(.template) // Ensure the SVG image color can be modified
                            .resizable() // Make the image resizable
                            .scaledToFit() // Ensure the image fits within the tab item
                            .frame(width: 24, height: 24) // Set the frame size
                            .foregroundColor(.white) // Set the color of the SVG image
                        Text("Services")
                    }
                
                AboutView(viewModel: AboutViewModel())
                    .tabItem{
                        Image(systemName: "info.circle.fill")
                        Text("About")
                    }
        }
        .tint(.white)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}


