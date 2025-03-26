//
//  TripDetailView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 25/03/25.
//

import SwiftUI

struct TripDetailView: View {
    let trip: TripModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    Text("Total \(trip.nameTrip) Trip")
                        .font(.title.bold())
                        .padding(.top)
                    Text("\(calculateTotalTripCost())")
                        .font(.largeTitle.bold())
                        .padding(.top,2)
                }
                .padding()
                
                if trip.destination.isEmpty {
                    Text("No destinations available")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    VStack(spacing: 15) {
                        ForEach(trip.destination) { destination in
                            DestinationDetailCard(destination: destination)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom)
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("Trip Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func calculateTotalTripCost() -> Int {
        trip.destination.reduce(0) { total, destination in
            total + calculateDestinationCost(destination)
        }
    }
    
    private func calculateDestinationCost(_ destination: DestinationModel) -> Int {
        let transportationCost: Int
            if destination.transportation == "Public" {
                transportationCost = destination.price ?? 0
            } else if destination.transportation == "Private", let bbm = destination.bbm, let distance = destination.distance {
                transportationCost = Int(bbm * distance)
            } else {
                transportationCost = 0
            }
            let baseCost = (destination.accommodation ?? 0) +
                           (destination.food ?? 0) +
                           (destination.entertainment ?? 0) +
                           transportationCost
            let emergencyFund = Int(Double(baseCost) * 0.2)
        return baseCost + emergencyFund
    }
}


#Preview {
    let sampleTrip = TripModel(nameTrip: "Bali Vacation", destinations: [
        DestinationModel(index: 1, title: "Beach", transportation: "Car", accommodation: 500000),
        DestinationModel(index: 2, title: "Resort", transportation: "Taxi", accommodation: 1000000)
    ])
    return TripDetailView(trip: sampleTrip)
}
