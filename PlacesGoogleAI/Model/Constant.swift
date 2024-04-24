//
//  Constant.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation

struct Constant {
    static let apiKey = "get from https://aistudio.google.com/app/apikey"
    static let prompt = """
    give me inspiration for activities that can be done during the day in the city of Bandar Lampung. Provide the response as an array of JSON as
    [
        {
            "place": "name",
            "activity": "activity",
            "price": "5.000"
        }
    ]
    
    only. Remove any backticks
    """
    
}
