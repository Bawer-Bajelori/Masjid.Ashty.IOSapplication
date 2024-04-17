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
                    }.background(Color(CustomColor.BackgroundColor!))
            
                CalendarView(viewModel: CalenderViewModel())
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }.background(Color(CustomColor.BackgroundColor!))
            
                ServicesView(viewModel: ServicesViewModel())
                    .tabItem{
                        Image("baseline_services_icon24")
                            .iconFormat()
                        Text("Services")
                    }.background(Color(CustomColor.BackgroundColor!))
                
                AboutView(viewModel: AboutViewModel())
                    .tabItem{
                        Image(systemName: "info.circle.fill")
                        Text("About")
                    }.background(Color(CustomColor.BackgroundColor!))
        }
        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}


