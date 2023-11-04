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
        //UITabBar.appearance().barTintColor = CustomColor.PrimaryColor
    }
    
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
        
            VideosView()
                .tabItem{
                    Image(systemName: "video.circle.fill")
                    Text("Live")
                }
            AboutView(viewModel: AboutViewModel())
                .tabItem{
                    Image(systemName: "info.circle.fill")
                    Text("About")
                    
                }
            ServicesView(viewModel: ServicesViewModel())
                .tabItem{
                    Image(systemName: "info.circle.fill")
                    Text("Services")
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



