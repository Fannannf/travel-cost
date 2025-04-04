//
//  ContentView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 16/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        HomeView()
            .modelContainer(for: [TripModel.self, DestinationModel.self])
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
