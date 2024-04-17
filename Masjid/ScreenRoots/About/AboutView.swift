import SwiftUI

struct AboutView: View {
    @StateObject var viewModel = AboutViewModel()

    var body: some View {
        VStack() {
            Text(viewModel.state.aboutTitle)
                .textTitle()
            Spacer().frame(height: 16)
            
            ScrollView() {
                VStack() {
                    Text(viewModel.state.aboutScreenDescription)
                        .textBodyPrimary(textAlignment: TextAlignment.center)
                                    
                    InfoItemColumn(
                        infoItems: viewModel.state.infoItems,
                        onClick: { infoItem in
                            viewModel.onInfoItemTapped(infoItem: infoItem)
                        }
                    )

                    Spacer().frame(height: 32)

                    Text(viewModel.state.socialMediaTitle)
                        .textTitle()

                    Spacer().frame(height: 16)
                    
                    SocialMediaRow(
                        socialMedia: viewModel.state.socialMedia,
                        onClick: viewModel.onWebLinkTapped(urlString:)
                    )

                    Spacer().frame(height: 32)

                    Text(viewModel.state.donateDescription)
                        .textBodyPrimary(textAlignment: TextAlignment.center)
                }
            }
            .frame(maxWidth: .infinity)
            
            DonateButton()
        }
        .background(Color(CustomColor.BackgroundColor! ))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
        .frame(maxWidth: .infinity)
    }
        
    struct InfoItemRow: View {
        var infoItem: InfoItem
        var onClick: () -> Void
        
        var body: some View {
            HStack() {
                ButtonWithIconAndText(text: infoItem.text, imageName: infoItem.iconID, action: onClick)
            }
        }
    }
    
    struct InfoItemColumn: View {
        var infoItems: [InfoItem]
        var onClick: (InfoItem) -> Void
        
        var body: some View {
            VStack(alignment: .leading) {
                
                ForEach(infoItems) { infoItem in
                    InfoItemRow(
                        infoItem: infoItem,
                        onClick: { self.onClick(infoItem) }
                    )
                }
            }
        }
    }
    
    struct SocialMediaRow: View {
        var socialMedia: [SocialMedia]
        var onClick: (String) -> Void
        
        var body: some View {
            HStack(alignment: VerticalAlignment.center) {
                
                ForEach(socialMedia) { socialMedia in
                    IconButton(imageName: socialMedia.iconID, imageColor: socialMedia.tint, onClick: { self.onClick(socialMedia.URL)} )
                }
            }
        }
    }
}
