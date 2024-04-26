//
//  ContentView.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var placeViewModel = PlaceViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(placeViewModel.place, id: \.self) { item in
                    PlaceRowComponent(place: item)
                }
            }
            .navigationTitle("Bandar Lampung")
            .overlay {
                placeViewModel.place.isEmpty ? ProgressView() : nil
            }
            .refreshable {
                await placeViewModel.getPlaces()
            }
            .onChange(of: placeViewModel.isApiKeyReady) { oldValue, newValue in
                if newValue {
                    Task {
                        await placeViewModel.getPlaces()
                    }
                }
            }
//            .task {
//                await placeViewModel.getPlaces()
//            }
        }
    }
}

#Preview {
    ContentView()
}
