//
//  TripModel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 23/03/25.
//

import Foundation
import SwiftData

@Model
class TripModel: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var nameTrip: String
    @Relationship(deleteRule: .cascade)
    var destination: [DestinationModel]
    
    init(nameTrip: String, destinations: [DestinationModel] = []) {
            self.nameTrip = nameTrip
            self.destination = destinations
        }
}
