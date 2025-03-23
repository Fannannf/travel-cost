//
//  TripEstimateViewModel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 22/03/25.
//

import Foundation

class TripEstimateViewModel: ObservableObject {
    @Published var tripName: String = ""
    @Published var destinations: [DestinationModel] = []
    
    init() {
        addDestination()
    }
    
    func addDestination() {
        let newIndex = destinations.isEmpty ? 1 : (destinations.last?.index ?? 0) + 1
        let newDestination = DestinationModel(index: newIndex)
        destinations.append(newDestination)
    }
    
    func updateDestination(_ destination: DestinationModel) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }) {
            destinations[index] = destination
        }
    }
    
    func transportationOptions(for type: String) -> [String] {
        switch type {
        case "Public":
            return ["Plane", "Train", "Bus", "Taxi", "Taxi Online"]
        case "Private":
            return ["Car", "Motorbike"]
        default:
            return []
        }
    }

    func calculateTotalCost() -> Int {
        var total = 0
        
        for destination in destinations {
            if destination.transportation == "Public" {
                total += Int(destination.price ?? 0)
            } else {
                if let bbm = destination.bbm, let distance = destination.distance, bbm > 0 {
                    let fuelCost = bbm * distance
                    total += Int(fuelCost)
                }
            }
            
            total += Int(destination.accommodation ?? 0)
            total += Int(destination.food ?? 0)
            total += Int(destination.entertainment ?? 0)
        }
        
        return total
    }
}
