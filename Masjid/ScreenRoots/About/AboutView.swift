import SwiftUI

struct AboutView: View {
    @StateObject var viewModel = AboutViewModel()

    var body: some View {
        VStack {
            Text(viewModel.state.aboutTitle)
                .textTitle()
            Spacer().frame(height: 16)
            
            ScrollView {
                
                Text(viewModel.state.aboutScreenDescription)
                    .textBodyPrimary()
                
                InfoItemColumn(
                    infoItems: viewModel.state.infoItems,
                    onClick: { infoItem in
                        viewModel.onInfoItemTapped(infoItem: infoItem)
                    }
                )

                Spacer().frame(height: 32)

                Text(viewModel.state.socialMediaTitle)
                    .font(.title)
                    .padding(.horizontal)

                Spacer().frame(height: 16)


                Text(viewModel.state.donateDescription)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
    
    struct InfoItemRow: View {
        var infoItem: InfoItem
        var onClick: () -> Void
        
        var body: some View {
            HStack {
                ButtonWithIconAndText(text: infoItem.text, imageName: infoItem.iconID, action: onClick)
            }
        }
    }
    
    struct InfoItemColumn: View {
        var infoItems: [InfoItem]
        var onClick: (InfoItem) -> Void
        
        var body: some View {
            VStack(spacing: 16) {
                
                ForEach(infoItems) { infoItem in
                    InfoItemRow(
                        infoItem: infoItem,
                        onClick: { self.onClick(infoItem) }
                    )
                }
                                   
            }
        }
    }
}
