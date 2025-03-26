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
    var price: Int?
    var accommodation: Int?
    var food: Int?
    var entertainment: Int?
    
    @Relationship(inverse: \TripModel.destination)
    var trip: TripModel?
    
    init(index: Int, title: String = "", transportation: String = "Public", transportationVehicle: String? = nil,
         bbm: Double? = nil, distance: Double? = nil, price: Int? = nil, accommodation: Int? = nil,
         food: Int? = nil, entertainment: Int? = nil) {
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
