//
//  DestinationModel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 19/03/25.
//

import Foundation

struct DestinationModel: Identifiable {
    var id = UUID()
    var index: Int
    var title: String = ""
    var transportation: String = "Public"
    var transportationVehicle: String?
    var bbm: Double?
    var distance: Double?
    var price: Double?
    var accommodation: Double?
    var food: Double?
    var entertainment: Double?
}
