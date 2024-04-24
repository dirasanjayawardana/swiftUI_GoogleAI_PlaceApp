//
//  PlaceModel.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation

struct PlaceModel: Codable, Hashable {
    var place: String
    var activity: String
    var price: String
}

extension PlaceModel {
    static let dummyData: [PlaceModel] = [
        PlaceModel(
            place: "Bakso Malang",
            activity: "Eat meat ball",
            price: "30.000"
        )
    ]
}
