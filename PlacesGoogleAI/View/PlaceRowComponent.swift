//
//  PlaceRowComponent.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct PlaceRowComponent: View {
    
    var place: PlaceModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text(place.activity)
                .font(.system(.title2, design: .rounded))
            
            HStack {
                Group {
                    Image(systemName: "pin")
                    Text(place.place)
                }
                .font(.subheadline)
                
                Spacer()
                
                HStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 20, height: 20)
                    
                    Text("RO\(place.price)")
                        .font(.subheadline)
                }
                .padding(8)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        })
    }
}

#Preview {
    PlaceRowComponent(place: PlaceModel.dummyData[0])
        .padding()
}
