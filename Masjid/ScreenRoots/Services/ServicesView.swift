//
//  SwiftUIView.swift
//  Masjid
//
//  Created by Bawer Bajelori on 3/1/23.
//

import SwiftUI

struct ServicesView: View {
    @State private var isExpanded = [false, false, false, false]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (spacing: 30) {
                    
                    disclosureGroup(title: " Marriage ", index: 0, content:
                                        {
                        Text(" Islamic marriage contracts are offered at the Prayer Center by appointment only.\n\nRequirements are:\n\n• Marriage license from Cook County court. (Please notify us beforehand if you live outside Cook County.)\n\n• Both groom and bride must bring a valid photo identification card like passport, driver license, ID card.\n\n• Bride must be accompanied by her father or guardian.\n\n• There must be two Muslim male witnesses to sign on the contract.\n\n• An amount of dowry (Mahr) between the two families must be agreed prior to the marriage ceremony.\n\n• The Islamic ceremony cannot be conducted on the same day the marriage license is obtained from the court. By law, 24 hours must pass before conducting the marriage ceremony.\n\n• There is no fee for the Islamic marriage ceremony but donations are graciously welcomed. ")
                            .padding()
                        
                    }
                    )
                    .border(Color.black)
                    .padding()
                    
                    // Divorce section
                    disclosureGroup( title: " Divorce ", index: 1,content: {
                        
                        Text("Islamic divorce contracts are offered at the Prayer Center per appointment only.\n\nRequirements are:\n\n• Divorce papers finalized from the civil court.\n\n• The presence of the husband to sign divorce papers. In rare cases phone calls instead of in-person appearance will suffice.\n\n• The wife must communicate details of the delayed amount of dowry with the Imam, in-person or per phone communication.\n\n• There are no fees required for the Islamic divorce but donations are graciously welcomed.")
                            .padding()
                    })
                    .border(Color.black)
                    .padding()
                    
                    
                    
                    // Counseling section
                    disclosureGroup( title: " Counseling ", index: 2,content: {
                        
                        Text("Counseling sessions are available at the Prayer Center by appointment.\n\nGuidelines:\n\n• Social, family, grief, and marital counseling sessions only.\n\n• Religious counseling only. We do not offer professional counseling at this time.\n\n• In most cases counseling shall be limited to three sessions only.")
                            .padding()
                        
                    })
                    .border(Color.black)
                    .padding()
                    
                    
                    // Funeral section
                    disclosureGroup(title: " Funeral ", index: 3,content:{
                        
                        Text("First, start by choosing a cemetary destination.\n\nNext, arrange for pre-burial processes. This includes:\n\n• Ghusl (the ritual body bathing)\n\n• Kafan (dressing)\n\n• Janaza Prayer (Islamic Funeral prayer)\n\nCemetary\n\n1- Greenwood memorial park\n\nKurdish Garden\n\n4300 Imperial Avenue\nSan Diego, CA 92113\n\n2-The Islamic Center of San Diego has acquired a new Islamic burial ground called:\n\nAl-Rahma Garden\nat La Vista Memorial Park\n3191 Orange Street\nNational City, CA 91950\nTel: 619-475-7770")
                            .padding()
                    })
                    .border(Color.black)
                    .padding()
                    
                    
                }
            }
        }
    }
    
    private func disclosureGroup<Content: View>(title:String, index: Int, @ViewBuilder content:@escaping ()->Content)-> some View{
        DisclosureGroup (
            isExpanded: $isExpanded[index],
            content: content,
            label: {
                Text(title)
                    .font(.title)
                    .padding(.leading, 10)
            }
            
        )
        .padding(.horizontal, 10)
        .padding()
    }
    
    
    struct ServicesView_Previews: PreviewProvider {
        static var previews: some View {
            ServicesView()
        }
    }
}
