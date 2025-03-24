//
//  TripEstimateViewModel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 22/03/25.
//

import Foundation
import SwiftData

@Observable
class TripEstimateViewModel: ObservableObject {
    var tripName: String = ""
    var destinations: [DestinationModel] = []
    
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
        destinations.reduce(0) { total, destination in
            var cost = 0
            
            if destination.transportation == "Public" {
                cost += Int(destination.price ?? 0)
            } else if let bbm = destination.bbm, let distance = destination.distance, bbm > 0 {
                cost += Int(bbm * distance)
            }
            
            cost += Int(destination.accommodation ?? 0)
            cost += Int(destination.food ?? 0)
            cost += Int(destination.entertainment ?? 0)
            
            return total + cost
        }
    }
    
    func saveTrip(context: ModelContext) {
        let newTrip = TripModel(nameTrip: tripName)
        context.insert(newTrip)
        for destination in destinations {
            let newDestination = DestinationModel(
                index: destination.index,
                title: destination.title,
                transportation: destination.transportation,
                transportationVehicle: destination.transportationVehicle,
                bbm: destination.bbm ?? 0,
                distance: destination.distance ?? 0,
                price: destination.price ?? 0,
                accommodation: destination.accommodation ?? 0,
                food: destination.food ?? 0,
                entertainment: destination.entertainment ?? 0
            )
            
            context.insert(newDestination)
            
            newTrip.destination.append(newDestination)
            newDestination.trip = newTrip
        }
        
        do {
            try context.save()
        } catch {
            print("Test save failed: \(error.localizedDescription)")
        }
    }
}

