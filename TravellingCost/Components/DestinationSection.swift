//
//  DestinationSection.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 18/03/25.
//

import SwiftUI

struct DestinationSection: View {
    @StateObject var viewModel = TripEstimateViewModel()
    var destinationId: UUID
    @State private var isExpanded: Bool = false
    
    private var destination: Binding<DestinationModel> {
            Binding<DestinationModel>(
                get: {
                    viewModel.destinations.first(where: { $0.id == destinationId }) ?? DestinationModel(index: 0)
                },
                set: { newValue in
                    viewModel.updateDestination(newValue)
                }
            )
        }
    
    @State private var showAccommodation = false
    @State private var showFood = false
    @State private var showEntertainment = false
    
    private func updateTransportation() {
        if let firstItem = viewModel.transportationOptions(for: destination.wrappedValue.transportation).first {
            destination.wrappedValue.transportationVehicle = firstItem
         }
     }

    var body: some View {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    VStack(alignment: .leading, spacing: 12) {
                        Divider()
                        
                        // Destination Name
                        HStack {
                            IconLabel(systemName: "mappin", color: .red)
                            Text("Title")
                            Spacer()
                            TextField("Destination", text: destination.title)
                                .multilineTextAlignment(.trailing)
                        }
                        Divider()
                        
                        // Transportation
                        HStack {
                            IconLabel(systemName: "car.rear.and.tire.marks", color: .red)
                            Text("Transportation")
                        }
                        Picker("Transportation", selection: destination.transportation) {
                            Text("Public").tag("Public")
                            Text("Private").tag("Private")
                        }
                        .pickerStyle(.segmented)
                        
                        Divider()
                        
                        // Conditional transportation details
                        if destination.wrappedValue.transportation == "Public" {
                            HStack {
                                IconLabel(systemName: "dollarsign", color: .red)
                                Text("Price")
                                Spacer()
                                TextField("Rp.", value: destination.price, formatter: NumberFormatter())
                                    .multilineTextAlignment(.trailing)
                                    .font(.body)
                            }
                        } else {
                            VStack(spacing: 12) {
                                HStack {
                                    IconLabel(systemName: "fuelpump", color: .red)
                                    Text("BBM")
                                    Spacer()
                                    TextField("25.000", value: destination.bbm, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                        .font(.body)
                                    Text("km/liter")
                                        .font(.body)
                                }
                                Divider()
                                HStack {
                                    IconLabel(systemName: "road.lanes", color: .red)
                                    Text("Distance")
                                    Spacer()
                                    TextField("20", value: destination.distance, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                        .font(.body)
                                    Text("km")
                                        .font(.body)
                                }
                            }
                        }
                        Divider()
                        
                        // Nested Disclosure Groups
                        DisclosureGroup {
                            TextField("Rp.", value: destination.accommodation, formatter: NumberFormatter())
                                .cornerRadius(8)
                                .keyboardType(.numberPad)
                                .font(.body)
                                .padding(.top, 4)
                        } label: {
                            HStack {
                                IconLabel(systemName: "house.fill", color: .red)
                                Text("Accommodation")
                                    .font(.body.bold())
                            }
                        }
                        
                        Divider()
                        
                        DisclosureGroup {
                            TextField("Rp.", value: destination.food, formatter: NumberFormatter())
                                .cornerRadius(8)
                                .keyboardType(.numberPad)
                                .font(.body)
                                .padding(.top, 4)
                        } label: {
                            HStack {
                                IconLabel(systemName: "fork.knife", color: .red)
                                Text("Food")
                                    .font(.body.bold())
                            }
                        }
                        
                        Divider()
                        
                        DisclosureGroup {
                            TextField("Rp.", value: destination.entertainment, formatter: NumberFormatter())
                                .cornerRadius(8)
                                .keyboardType(.numberPad)
                                .font(.body)
                                .padding(.top, 4)
                        } label: {
                            HStack {
                                IconLabel(systemName: "handbag.fill", color: .red)
                                Text("Entertainment")
                                    .font(.body.bold())
                            }
                        }
                    }
                    .padding(.top, 8)
                },
                label: {
                    Text("Destination \(destination.wrappedValue.index)")
                        .font(.title3.bold())
                }
            )
            .font(.body.bold())
            .padding()
            .background(.white)
            .cornerRadius(12)
            .padding(.horizontal, 10)
            .shadow(color: Color("shadowColor"), radius: 6, y: 5)
            .onAppear {
                updateTransportation()
            }
        }
}
