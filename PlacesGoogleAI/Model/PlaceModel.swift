//
//  PlaceModel.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation

struct PlaceModel: Codable {
    var place: String
    var activity: String
    var price: String
}

extension PlaceModel {
    static let dummyData: [PlaceModel] = [
        PlaceModel(
            place: "Bakso Malang",
            activity: "Makan",
            price: "30.000"
        )
    ]
}
