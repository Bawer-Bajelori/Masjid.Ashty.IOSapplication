//
//  HomeView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/18/23.
//



import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        switch viewModel.state.loadingState {
            case .loading:
                LoadingScreen()
            case .error:
                ErrorMessageScreen(
                    text: viewModel.state.errorMessage,
                    buttonText: viewModel.state.errorButtonMessage,
                    onClick: { viewModel.errorButtonOnClick() }
                )
            case .success:
            HomeViewSuccess(state: viewModel.state)
        }
    }
    
    
}

struct HomeViewSuccess: View {
    var state: HomeViewState
    
    var body: some View {
        VStack {
            
            KhutbahTimesView(
                khutbah1Time: state.khutbah1Time,
                khutbah2Time: state.khutbah2Time
            )
            .padding(.bottom, 2 )
            
            //have to put PrayerTimeCard below KhutbahTimesView for correct display
            PrayerTimeCard(
                prayerTimes: state.prayerTimes,
                prayerColumnTitle: state.prayerColumnTitle,
                athanColumnTitle: state.athanColumnTitle,
                iqamaColumnTitle: state.iqamaColumnTitle
            )
        }
        .background(Color(CustomColor.BackgroundColor!))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct KhutbahTimesView: View {
    var khutbah1Time: String
    var khutbah2Time: String
    
    var body: some View {
        ZStack{
            RoundedBorderShape(cornerRadius: 5)
                .stroke(Color.blue, lineWidth: 1)
                           .background(Color.black.opacity(0.7).cornerRadius(5))
                           .frame(height: 70)
            
            VStack  {
                Text("Friday Khutbah")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                HStack{
                    
                    
                    Text("English/Arabic: \(khutbah1Time)")
                        .font(.subheadline)
                        .padding(.bottom, 1)
                    
                    
                    
                    Text(" Kurdish/English: \(khutbah2Time)")
                        .font(.subheadline)
                        .padding(.bottom, 1)
                    
                }
            }
            
        }
        .padding()
    }
}



struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(Color(CustomColor.BackgroundColor!))
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedBorderShape(cornerRadius: 10)
                    .stroke(Color(CustomColor.PrimaryColor!), lineWidth: 1.5)
            )
    }
    
}

struct PrayerTimeCard: View {
    var prayerTimes: [PrayerTime]
    var prayerColumnTitle: String
    var athanColumnTitle: String
    var iqamaColumnTitle: String
    
    var body: some View {
        
        CardView {
            PrayerTimeTable(
                prayerTimes: prayerTimes,
                prayerColumnTitle: prayerColumnTitle,
                athanColumnTitle: athanColumnTitle,
                iqamaColumnTitle: iqamaColumnTitle
            )
        }
        .padding()
    }
}

struct PrayerTimeTable: View {
    var prayerTimes: [PrayerTime]
    var prayerColumnTitle: String
    var athanColumnTitle: String
    var iqamaColumnTitle: String
    
    var body: some View {
        VStack {
            PrayerTimeTableLegend(
                prayerColumnTitle: prayerColumnTitle,
                athanColumnTitle: athanColumnTitle,
                iqamaColumnTitle: iqamaColumnTitle
            )
            
            Divider()
                .frame(height: 1.5)
                .background(Color(CustomColor.PrimaryVariant!))
                
            ForEach(prayerTimes, id: \.type) { prayerTime in
                PrayerTimeRow(prayerTime: prayerTime)
            
                Divider()
                    .frame(height: 1.5)
                    .background(Color(CustomColor.PrimaryColor!))
            }
            
        }
    }
}

struct PrayerTimeTableLegend: View {
    var prayerColumnTitle: String
    var athanColumnTitle: String
    var iqamaColumnTitle: String
     
    var body: some View {
        HStack {
            Text(prayerColumnTitle)
                .textBodyPrimary(fontWeight: Font.Weight.bold)
                .frame(maxWidth: .infinity, alignment: Alignment.leading)
            Spacer()
            Text(athanColumnTitle)
                .textBodyPrimary(fontWeight: Font.Weight.bold)
                .frame(maxWidth: .infinity, alignment: Alignment.center)
            Spacer()
            Text(iqamaColumnTitle)
                .textBodyPrimary(fontWeight: Font.Weight.bold)
                .frame(maxWidth: .infinity, alignment: Alignment.trailing)
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
    }
}

struct PrayerTimeRow: View {
    var prayerTime: PrayerTime
    
    var body: some View {
        HStack {
            Text(prayerTime.type.prayerName)
                .textBodyPrimary()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(prayerTime.prayerTime)
                .textBodyPrimary()
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            Text(prayerTime.iqamaTime ?? "")
                .textBodyPrimary()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 16)
    }
}

   struct HomeView_Previews: PreviewProvider {
       static var previews: some View {
           HomeView(viewModel: HomeViewModel())
       }
   }

