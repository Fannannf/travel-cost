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
    @State private var isExpanded: Bool = true
    @FocusState private var isTextFieldFocused: Bool
    
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
                        HStack {
                            IconLabel(systemName: "car.rear.and.tire.marks")
                            Text("Transportation")
                        }
                        Picker("Select Transportation", selection: destination.transportation) {
                            Text("Public").tag("Public")
                            Text("Private").tag("Private")
                        }
                        .pickerStyle(.segmented)
                        Divider()
                        if destination.wrappedValue.transportation == "Public" {
                            HStack {
                                IconLabel(systemName: "dollarsign")
                                Text("Price")
                                Spacer()
                                TextField("Rp.25.000", value: destination.price, formatter: NumberFormatter())
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                                    .font(.body)
                                    .focused($isTextFieldFocused)
                            }
                        } else {
                            VStack(spacing: 12) {
                                HStack {
                                    IconLabel(systemName: "fuelpump")
                                    Text("Fuel")
                                    Spacer()
                                    TextField("Rp.25.000", value: destination.bbm, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                        .font(.body)
                                        .focused($isTextFieldFocused)
                                    Text("km/liter")
                                        .font(.body)
                                }
                                Divider()
                                HStack {
                                    IconLabel(systemName: "road.lanes")
                                    Text("Distance")
                                    Spacer()
                                    TextField("20", value: destination.distance, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                        .font(.body)
                                        .focused($isTextFieldFocused)
                                    Text("km")
                                        .font(.body)
                                }
                            }
                        }
                        Divider()
                        Group{
                            ExpandableSection(title: "Accommodation",icon: "house.fill", content: {
                                TextField("Rp.25.000", value: destination.accommodation, formatter: NumberFormatter())
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .font(.body)
                                    .focused($isTextFieldFocused)
                            }, isExpanded: $showAccommodation)
                            Divider()
                            ExpandableSection(title: "Food",icon: "fork.knife", content: {
                                TextField("Rp.25.000", value: destination.food, formatter: NumberFormatter())
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .font(.body)
                                    .focused($isTextFieldFocused)
                                
                            }, isExpanded: $showFood)
                            Divider()
                            ExpandableSection(title: "Entertainment",icon: "handbag.fill", content: {
                                TextField("Rp.25.000",value: destination.entertainment, formatter: NumberFormatter())
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .font(.body)
                                    .focused($isTextFieldFocused)
                                
                            }, isExpanded: $showEntertainment)
                        }
                    }
                    .padding(.top, 8)
                },
                label: {
                    TextField("Enter Destination", text: destination.title)
                        .padding(.leading,20)
                        .overlay(
                                Text("*")
                                    .foregroundColor(.red)
                                    .font(.title),
                                alignment: .leading
                            )
                        .multilineTextAlignment(.leading)
                        .focused($isTextFieldFocused)
                }
            )
            .tint(.indigo)
            .font(.body.bold())
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .padding(.horizontal, 5)
            .onTapGesture {
                if isTextFieldFocused {
                    isTextFieldFocused = false
                }
            }
            .onAppear {
                updateTransportation()
            }
        }
}

#Preview {
    HomeView()
}
