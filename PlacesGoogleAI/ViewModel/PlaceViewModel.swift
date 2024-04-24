//
//  PlaceViewModel.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation
import GoogleGenerativeAI

@MainActor
class PlaceViewModel: ObservableObject {
    private var geminiModel: GenerativeModel
    
    @Published var place: [PlaceModel] = []
    
    init() {
        self.geminiModel = GenerativeModel(name: "gemini-pro", apiKey: Constant.apiKey)
    }
    
    func getPlaces() async {
        let prompt = Constant.prompt
        
        do {
            let response = try await geminiModel.generateContent(prompt)
            guard
                let text = response.text,
                let data = text.data(using: .utf8)
            else {
                print("Unable to convert text or data")
                return
            }
            
            place = try JSONDecoder().decode([PlaceModel].self, from: data)
            
        } catch {
            print("Error fetching places: \(error.localizedDescription)")
        }
    }
}
