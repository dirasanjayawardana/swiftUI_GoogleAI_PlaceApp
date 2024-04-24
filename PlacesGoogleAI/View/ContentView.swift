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
            .task {
                await placeViewModel.getPlaces()
            }
            .refreshable {
                await placeViewModel.getPlaces()
            }
        }
    }
}

#Preview {
    ContentView()
}
