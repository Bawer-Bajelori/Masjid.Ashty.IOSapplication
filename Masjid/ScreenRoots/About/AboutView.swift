//
//  AboutView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/18/23.
//

import SwiftUI

struct AboutView : View{
    var viewModel: AboutViewModel
    var body: some View{
        
        ScrollView{
            ZStack{
                VStack{
                    
                    
                    
                    Text(viewModel.state.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                    Spacer()
                    
                    
                    Text(viewModel.state.subtitle)
                        .padding()
                        .font(.headline)
                    
                    
                    
                    ForEach(viewModel.state.infoItemList){ i in
                        HStack{
                            Text(i.displayText)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                        }
                    }
                }
                //            .background(Color.init(uiColor: CustomColor.customBackgroundColor ?? .white))
                
            }.background(Color.init(uiColor: CustomColor.BackgroundColor ?? .white))
        }
    }
            
//            //struct InfoItemRow: View {
//
//                var infoItem: InfoItem
//                var body: some View{
//                    HStack{
//                        Text(infoItem.displayText)
//                        Text(infoItem.displayText)
//                    }
//                }
//            }
        
            
        
        
        struct AboutView_Previews: PreviewProvider {
            static var previews: some View {
                AboutView(viewModel: AboutViewModel())
                
            }
        }
    }


