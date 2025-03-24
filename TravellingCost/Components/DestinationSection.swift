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
        VStack(alignment: .leading, spacing: 12) {
            Text("Destination \(destination.wrappedValue.index)")
                            .font(.title3.bold())
            Divider()
            HStack {
                Image(systemName: "mappin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .padding(5)
                    .background(Color.red.opacity(0.2))
                    .clipShape(Circle())
                    .foregroundColor(.red.opacity(0.8))
                Text("Title")
                Spacer()
                TextField("Destination", text: destination.title)
                    .multilineTextAlignment(.trailing)
            }
            Divider()
            HStack{
                Image(systemName: "car.rear.and.tire.marks")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .padding(5)
                    .background(Color.red.opacity(0.2))
                    .clipShape(Circle())
                    .foregroundColor(.red.opacity(0.8))
                
                Text("Transportation")
            }
            Picker("Transportation", selection: destination.transportation) {
                Text("Public").tag("Public")
                Text("Private").tag("Private")
            }
            .pickerStyle(.segmented)
            .onChange(of: destination.wrappedValue.transportation) { newValue in
                updateTransportation()
            }
            
            HStack {
                Text("Vehicle")
                Spacer()
                Picker("TransportationType", selection: destination.transportationVehicle) {
                    ForEach(viewModel.transportationOptions(for: destination.wrappedValue.transportation), id: \.self) { option in
                                            Text(option).tag(option)
                                        }
                }
                .tint(Color(.red))
            }
            
            Divider()
            if destination.wrappedValue.transportation == "Public" {
                HStack{
                    Image(systemName: "dollarsign")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                    Text("Price")
                    TextField("Rp.", value: destination.price, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                        .font(.body)
                    
                }
            } else {
                VStack {
                    HStack{
                        Image(systemName: "fuelpump")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .padding(5)
                            .background(Color.red.opacity(0.2))
                            .clipShape(Circle())
                            .foregroundColor(.red.opacity(0.8))
                        Text("BBM")
                        TextField("25.000", value: destination.bbm, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.body)
                        
                        Text("km/liter")
                            .font(.body)
                    }
                    Divider()
                    HStack{
                        Image(systemName: "road.lanes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .padding(5)
                            .background(Color.red.opacity(0.2))
                            .clipShape(Circle())
                            .foregroundColor(.red.opacity(0.8))
                        Text("Distance")
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
            Group {
                ExpandableSection(title: "Accommodation",icon: "house.fill", content: {
                    TextField("Rp.", value: destination.accommodation, formatter: NumberFormatter())
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .font(.body)
                }, isExpanded: $showAccommodation)
                Divider()
                ExpandableSection(title: "Food",icon: "fork.knife", content: {
                    TextField("Rp.", value: destination.food, formatter: NumberFormatter())
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .font(.body)
                    
                }, isExpanded: $showFood)
                Divider()
                ExpandableSection(title: "Entertainment",icon: "handbag.fill", content: {
                    TextField("Rp.",value: destination.entertainment, formatter: NumberFormatter())
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .font(.body)
                    
                }, isExpanded: $showEntertainment)
            }
        }
        .font(.body.bold())
        .padding()
        .background(.white)
        .cornerRadius(12)
        .padding(.horizontal,10)
        .shadow(color: Color("shadowColor"), radius: 6,y: 5)
        .onAppear {
            updateTransportation()
        }
    }
}
