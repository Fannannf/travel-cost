//
//  DestinationOutput.swift
//  TravellingCost
//
//  Created by Zhafira Zahra on 24/03/25.
//

import SwiftUI

struct DestinationOutput: View {
    @ObservedObject var viewModel: TripEstimateViewModel
    @State private var isExpanded = true
    var destinationId: UUID
    
    private var destination: DestinationModel? {
        viewModel.destinations.first(where: { $0.id == destinationId })
    }
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                contentView
            },
            label: {
                Text(destination?.title ?? "Unknown Destination")
                    .fontWeight(.bold)
            }
        )
        .font(.body.bold())
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding(.horizontal, 5)
    }
    
    private var contentView: some View {
        Group {
            if let destination = destination {
                VStack(spacing: 12) {
                    // Accommodation cost row
                    costRowIfNonZero(
                        value: destination.accommodation,
                        icon: "house.fill",
                        title: "Accommodation"
                    )
                    
                    // Transportation cost row
                    transportationCostRow(for: destination)
                    
                    // Food cost row
                    costRowIfNonZero(
                        value: destination.food,
                        icon: "fork.knife",
                        title: "Food"
                    )
                    
                    // Entertainment cost row
                    costRowIfNonZero(
                        value: destination.entertainment,
                        icon: "handbag.fill",
                        title: "Entertainment"
                    )
                    
                    // Calculate base cost and emergency fund
                    emergencyFundSection(for: destination)
                }
                .padding(.top)
            }
        }
    }
    
    private func costRowIfNonZero(value: Int?, icon: String, title: String) -> some View {
        Group {
            if let value = value, value > 0 {
                itemRow(icon: icon, title: title, value: value)
            }
        }
    }
    
    private func transportationCostRow(for destination: DestinationModel) -> some View {
        Group {
            if destination.transportation == "Public",
               let price = destination.price,
               price > 0 {
                itemRow(icon: "bus.fill", title: "Public Transport", value: price)
            } else if destination.transportation == "Private",
                      let bbm = destination.bbm,
                      let distance = destination.distance,
                      bbm > 0 {
                let privateTransportCost = Int(bbm * distance)
                itemRow(icon: "car.fill", title: "Private Transport", value: privateTransportCost)
            }
        }
    }
    
    private func emergencyFundSection(for destination: DestinationModel) -> some View {
        Group {
            let baseCost = calculateBaseCost(for: destination)
            let emergencyFund = Int(Double(baseCost) * 0.2)
            
            itemRow(icon: "dollarsign.circle", title: "Emergency Fund", value: emergencyFund)
            
            HStack {
                Spacer()
                Text("Rp. \(viewModel.calculateCost(for: destination))")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .padding(.top)
        }
    }
    
    private func calculateBaseCost(for destination: DestinationModel) -> Int {
        var privateTransportCost = destination.transportation == "Private" &&
        destination.bbm != nil &&
        destination.distance != nil
        ? Int(destination.bbm! * destination.distance!)
        : 0
        let mutableDestination = destination
        if destination.transportation == "Private" {
            mutableDestination.price = 0
        }
        if destination.transportation == "Public"{
            privateTransportCost = 0
        }
        return (destination.accommodation ?? 0) +
        (destination.price ?? 0) +
        (destination.food ?? 0) +
        (destination.entertainment ?? 0) +
        privateTransportCost
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

