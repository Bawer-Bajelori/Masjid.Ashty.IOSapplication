//
//  HomeView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/18/23.
//



import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView("Loading...")
            case .error(let message):
                VStack {
                    Text(message)
                    Button("Retry") {
                        viewModel.errorButtonOnClick()
                    }
                }
            case .success(let prayerTimes):
                List(prayerTimes) { prayerTime in
                    VStack(alignment: .leading) {
                        Text(prayerTime.name)
                            .font(.title)
                        Text(prayerTime.prayerTime)
                            .font(.headline)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchPrayerData()
        }
    }
}

   struct HomeView_Previews: PreviewProvider {
       static var previews: some View {
           HomeView(viewModel: HomeViewModel())
       }
   }

