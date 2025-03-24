//
//  TravellingCostApp.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 16/03/25.
//

import SwiftUI
import SwiftData

@main
struct TravellingCostApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [TripModel.self, DestinationModel.self])
    }
}
