//
//  DestinationModel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 19/03/25.
//

import Foundation
import SwiftData

@Model
class DestinationModel: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var index: Int
    var title: String
    var transportation: String
    var transportationVehicle: String?
    var bbm: Double?
    var distance: Double?
    var price: Double?
    var accommodation: Double?
    var food: Double?
    var entertainment: Double?
    
    @Relationship(inverse: \TripModel.destination)
    var trip: TripModel?
    
    init(index: Int, title: String = "", transportation: String = "Public", transportationVehicle: String? = nil,
         bbm: Double? = nil, distance: Double? = nil, price: Double? = nil, accommodation: Double? = nil,
         food: Double? = nil, entertainment: Double? = nil) {
        self.index = index
        self.title = title
        self.transportation = transportation
        self.transportationVehicle = transportationVehicle
        self.bbm = bbm
        self.distance = distance
        self.price = price
        self.accommodation = accommodation
        self.food = food
        self.entertainment = entertainment
    }
}
