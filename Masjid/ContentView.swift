//
//  ContentView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/12/23.
//
import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView(viewModel: HomeViewModel())
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            CalendarView(viewModel:CalenderViewModel())
                .tabItem{
                    Image(systemName: "calendar.circle")
                    Text("Calendar")
                }
            VideosView()
                .tabItem{
                    Image(systemName: "video.circle.fill")
                    Text("Live")
                }
            AboutView(viewModel: AboutViewModel())
                .tabItem{
                    Image(systemName: "ellipsis.circle.fill")
                    Text("About")
                    
                }
            ServicesView()
                .tabItem{
                
                    Image(systemName: "info.circle.fill")
                    Text("Services")
                }
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}



