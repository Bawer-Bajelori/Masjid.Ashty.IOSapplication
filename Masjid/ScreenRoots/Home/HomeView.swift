import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("mosque_no_moon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                    .padding(.top, -10)

                VStack {
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
                .padding(.top, -geometry.size.height * 0.15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeViewSuccess: View {
    var state: HomeViewState
    var body: some View {
        VStack(spacing: 0) {
            KhutbahTimesView(
                khutbah1Time: state.khutbah1Time,
                khutbah2Time: state.khutbah2Time
            )
            .padding(.bottom, 2)
            
            PrayerTimeCard(
                prayerTimes: state.prayerTimes,
                prayerColumnTitle: state.prayerColumnTitle,
                athanColumnTitle: state.athanColumnTitle,
                iqamaColumnTitle: state.iqamaColumnTitle,
                currentPrayerType: state.currentPrayerType
            )
            .padding(.top, 0)
        }
        .background(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct KhutbahTimesView: View {
    var khutbah1Time: String
    var khutbah2Time: String
    
    var body: some View {
        ZStack {
            RoundedBorderShape(cornerRadius: 5)
                .stroke(Color.blue, lineWidth: 1)
                .background(Color.clear)
                .frame(height: 50)
            
            VStack {
                Text("Friday Khutbah")
                    .font(.headline)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                HStack {
                    Text("English/Arabic: \(khutbah1Time)")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                        .foregroundColor(.white)

                    Text("   Kurdish/English: \(khutbah2Time)")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                        .foregroundColor(.white)
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
            .background(Color.clear)
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedBorderShape(cornerRadius: 10)
                    .stroke(Color(CustomColor.PrimaryColor!), lineWidth: 1.5)
            )
            .padding(10)
    }
}

struct PrayerTimeCard: View {
    var prayerTimes: [PrayerTime]
    var prayerColumnTitle: String
    var athanColumnTitle: String
    var iqamaColumnTitle: String
    var currentPrayerType: PrayerType?
    
    var body: some View {
        CardView {
            PrayerTimeTable(
                prayerTimes: prayerTimes,
                prayerColumnTitle: prayerColumnTitle,
                athanColumnTitle: athanColumnTitle,
                iqamaColumnTitle: iqamaColumnTitle,
                currentPrayerType: currentPrayerType
            )
            .background(Color.clear)
        }
        .padding()
    }
}

struct PrayerTimeTable: View {
    var prayerTimes: [PrayerTime]
    var prayerColumnTitle: String
    var athanColumnTitle: String
    var iqamaColumnTitle: String
    var currentPrayerType: PrayerType?
    
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
                PrayerTimeRow(
                    prayerTime: prayerTime,
                    isCurrentPrayer: prayerTime.type == currentPrayerType
                )
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
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: Alignment.leading)
            
            Spacer()
            
            Text(athanColumnTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: Alignment.center)
            
            Spacer()
            
            Text(iqamaColumnTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: Alignment.trailing)
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
    }
}

struct PrayerTimeRow: View {
    var prayerTime: PrayerTime
    var isCurrentPrayer: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Text(prayerTime.type.prayerName)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
            
            Text(prayerTime.prayerTime)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(prayerTime.iqamaTime ?? "")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
        .background(isCurrentPrayer ? Color.blue.opacity(0.8) : Color.clear)
        .cornerRadius(10)
        .padding(.horizontal, 4)
    }
}
