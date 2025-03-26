//
//  DestinationDetailCard.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 25/03/25.
//

import SwiftUI

struct DestinationDetailCard: View {
    let destination: DestinationModel
    private var emergencyFund: Int {
            let transportationCost = calculateTransportationCost()
            let baseCost = (destination.accommodation ?? 0) +
            (destination.price ?? 0) +
            (destination.food ?? 0) +
            (destination.entertainment ?? 0) +
            transportationCost
            return Int(Double(baseCost) * 0.2)
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(destination.title)")
            VStack(spacing: 10) {
                
                if destination.transportation == "Public", let price = destination.price, price > 0 {
                    itemRow(icon: "bus.fill", title: "Public Transport", value: price)
                } else if destination.transportation == "Private", let bbm = destination.bbm, let distance = destination.distance, bbm > 0 {
                    let privateTransportCost = Int(bbm * distance)
                    itemRow(icon: "car.fill", title: "Private Transport", value: privateTransportCost)
                }
                
                if let accommodation = destination.accommodation, accommodation > 0 {
                    itemRow(icon: "house.fill", title: "Accommodation", value: accommodation)
                }
                
                if let food = destination.food, food > 0 {
                    itemRow(icon: "fork.knife", title: "Food", value: food)
                }
                
                if let entertainment = destination.entertainment, entertainment > 0 {
                    itemRow(icon: "handbag.fill", title: "Entertainment", value: entertainment)
                }
                itemRow(icon: "dollarsign.circle", title: "emergency fund", value: emergencyFund)
                HStack {
                    Spacer()
                    Text("Rp. \(calculateDestinationCost())")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                .padding(.top)
            }
        }
        .font(.body.bold())
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding(.horizontal, 5)
    }
    
    private func calculateTransportationCost() -> Int {
            if destination.transportation == "Private",
                      let bbm = destination.bbm,
                      let distance = destination.distance {
                return Int(bbm * distance)
            }
            return 0
        }
        
        private func calculateDestinationCost() -> Int {
            let transportationCost = calculateTransportationCost()
            let baseCost = (destination.accommodation ?? 0) +
            (destination.price ?? 0) +
            (destination.food ?? 0) +
            (destination.entertainment ?? 0) +
            transportationCost
            return baseCost + emergencyFund
        }
}

@ViewBuilder
private func itemRow(icon: String, title: String, value: Int) -> some View {
    VStack {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(5)
                .foregroundColor(.gray.opacity(0.5))
            Text(title)
                .multilineTextAlignment(.leading)
            Spacer()
            Text("Rp. \(value)")
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.trailing)
        }
        Divider()
    }
}

#Preview {
    DestinationDetailCard(destination:  DestinationModel(index: 1, title: "Beach", transportation: "Car", accommodation: 500000))
}
