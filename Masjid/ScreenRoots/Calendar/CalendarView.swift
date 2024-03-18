//
//  CalendarView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/18/23.
//
import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalenderViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.state.calendarTitle)
                .font(.title)
                .padding()
            
            Text(viewModel.state.buttonText)
                .font(.title2)
                .padding()
            
            switch viewModel.state.loadingState {
            case .loading:
                ProgressView()
                
            case .success:
                List {
                    ForEach(viewModel.state.days) { day in
                        Section(header: Text("Day \(day.id.uuidString)")) {
                            ForEach(day.prayerTimes, id: \.name) { prayerTime in
                                HStack {
                                    Text(prayerTime.name)
                                    Spacer()
                                    Text(prayerTime.prayerTime)
                                }
                            }
                        }
                    }
                }
                
            case .error(let errorMessage):
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Button(action: {
                    // Trigger your network fetch or other error recovery here
                }) {
                    Text(viewModel.state.errorButtonMessage)
                }
            }
        }
        .onAppear(perform: {
            // Trigger initial fetch when the view appears
            viewModel.fetchCalendarTimes()
        })
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
    }
}
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: CalenderViewModel())
    }
}
