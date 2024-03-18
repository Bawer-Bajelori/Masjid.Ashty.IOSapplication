//
//  ServicesViewModel.swift
//  Masjid
//
//  Created by Lawand Piromari on 10/24/23.
//

import Foundation

struct ServicesViewState {
    let servicesTitle: String
    let sevicesScreenDescription: String
    let services: [Service]
}

struct Service {
    let title: String
    let text: String
}

class ServicesViewModel: ObservableObject {
    @Published var state: ServicesViewState = createServicesViewState()

}

func createServicesViewState() -> ServicesViewState {
    return ServicesViewState(
        servicesTitle: "Services",
        sevicesScreenDescription: "Masjid Ashty provides plenty of services to its community, Including:",
        services: [
            Service(title: "Marriage", text: "Islamic marriage contracts are offered at the Prayer Center by appointment only.\n" +
                    "\n" +
                    "Requirements are:\n" +
                    "\n" +
                    "• Marriage license from Cook County court. (Please notify us beforehand if you live outside Cook County.)\n\n" +
                    "• Both groom and bride must bring a valid photo identification card like passport, driver license, ID card.\n\n" +
                    "• Bride must be accompanied by her father or guardian.\n\n" +
                    "• There must be two Muslim male witnesses to sign on the contract.\n\n" +
                    "• An amount of dowry (Mahr) between the two families must be agreed prior to the marriage ceremony.\n\n" +
                    "• The Islamic ceremony cannot be conducted on the same day the marriage license is obtained from the court. By law, 24 hours must pass before conducting the marriage ceremony.\n\n" +
                    "• There is no fee for the Islamic marriage ceremony but donations are graciously welcomed."),
            Service(title: "Divorce", text: "Islamic divorce contracts are offered at the Prayer Center per appointment only.\n" +
                    "\n" +
                    "Requirements are:\n" +
                    "\n" +
                    "• Divorce papers finalized from the civil court.\n\n" +
                    "• The presence of the husband to sign divorce papers. In rare cases phone calls instead of in-person appearance will suffice.\n\n" +
                    "• The wife must communicate details of the delayed amount of dowry with the Imam, in-person or per phone communication.\n\n" +
                    "• There are no fees required for the Islamic divorce but donations are graciously welcomed."),
            Service(title: "Counseling", text: "Counseling sessions are available at the Prayer Center by appointment.\n" +
                    "\n" +
                    "Guidelines:\n" +
                    "\n" +
                    "• Social, family, grief, and marital counseling sessions only.\n\n" +
                    "• Religious counseling only. We do not offer professional counseling at this time.\n\n" +
                    "• In most cases counseling shall be limited to three sessions only."),
            Service(title: "Funeral", text: "First, start by choosing a cemetery destination.\n" +
                    "Next, arrange for pre-burial processes. This includes: \n" +
                    "\n" +
                    "• Ghusl (the ritual body bathing) \n" +
                    "\n" +
                    "• Kafan (dressing) \n" +
                    "\n" +
                    "• Janaza Prayer (Islamic Funeral prayer)\n" +
                    "\n" +
                    "Cemeteries:\n" +
                    "\n" +
                    "1- Greenwood memorial park\n" +
                    "\n" +
                    "Kurdish Garden\n" +
                    "\n" +
                    "4300 Imperial Avenue\n" +
                    " San Diego, CA 92113\n" +
                    "\n" +
                    "2-The Islamic Center of San Diego has acquired a new Islamic burial ground called: \n" +
                    "\n" +
                    "Al-Rahma Garden\n\n" +
                    "at La Vista Memorial Park\n" +
                    "3191 Orange Street\n" +
                    "National City, CA 91950\n" +
                    "Tel: 619-475-7770 ")
        ]
    )
}
