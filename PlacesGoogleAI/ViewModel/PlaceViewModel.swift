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
    private var geminiModel: GenerativeModel?
    
    @Published var place: [PlaceModel] = []
    @Published var isApiKeyReady: Bool = false
    
    init() {
        // self.geminiModel = GenerativeModel(name: "gemini-pro", apiKey: Constant.apiKey)
        configureGenerativeModel()
    }
    
    func configureGenerativeModel() {
        Task {
            do {
                let apiKey: String = try await RemoteConfigService.shared.fetchConfig(forKey: .apiKey)
                self.geminiModel = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
                self.isApiKeyReady = true
            } catch {
                print("Error configuration GenerativeModel: \(error)")
            }
        }
    }
    
    func getPlaces() async {
        let prompt = Constant.prompt
        
        guard let geminiModel = self.geminiModel else {
            print("GenerativeModel is not configure")
            return
        }
        
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
