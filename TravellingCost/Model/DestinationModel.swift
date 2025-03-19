//
//  DestinationModel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 19/03/25.
//

import Foundation

struct DestinationModel {
    var id: UUID = UUID()
    var title: String
    var transportation: TransportationType
    var transportationVehicle: String
    var bbm: Double?
    var distance: Double?
    var price: Double?
    var accommodation: Double?
    var food: Double?
    var entertainment: Double?
}

enum TransportationType: String, CaseIterable, Identifiable {
    case `public` = "Public"
    case `private` = "Private"
    
    var id: String { self.rawValue }
}
