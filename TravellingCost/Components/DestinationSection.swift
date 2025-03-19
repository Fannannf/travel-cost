//
//  DestinationSection.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 18/03/25.
//

import SwiftUI

struct DestinationSection: View {
    var numberDestination: Int
    @State private var tripName: String = ""
    @State private var destination: String = ""
    @State private var price: String = ""
    @Binding var transportationType: String
    
    @State private var transportation: String = "Plane"
    @State private var accommodation: String = ""
    @State private var showAccommodation = false
    @State private var showFood = false
    @State private var showEntertainment = false
    
    private func updateTransportation() {
        if let firstItem = transportationCategory().first {
            transportation = firstItem
        }
    }
    
    private func transportationCategory() -> [String] {
        switch transportationType {
        case "Public":
            return ["Plane","Train","Bus","Taxi","Taxi Online"]
        case "Private":
            return ["Car","Motorbike"]
        default:
            return []
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Destination \(numberDestination)")
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
                TextField("Destination", text: $destination)
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
            Picker("Transportation", selection: $transportationType) {
                Text("Public").tag("Public")
                Text("Private").tag("Private")
            }
            .pickerStyle(.segmented)
            .onChange(of: transportationType) { _ in
                updateTransportation()
            }
            
            HStack {
                Text("Vehicle")
                Spacer()
                Picker("TransportationType", selection: $transportation) {
                    ForEach(transportationCategory(), id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
            }
            
            Divider()
            if transportationType == "Public" {
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
                    TextField("Rp.", text: $price)
                        .multilineTextAlignment(.trailing)
                }
            }
            Divider()
            Group {
                ExpandableSection(title: "Accommodation",icon: "house.fill", content: {
                    TextField("Rp.", text: $accommodation)
                        .cornerRadius(8)
                }, isExpanded: $showAccommodation)
                Divider()
                ExpandableSection(title: "Food",icon: "fork.knife", content: {
                    TextField("Rp.", text: $accommodation)
                        .cornerRadius(8)
                }, isExpanded: $showFood)
                Divider()
                ExpandableSection(title: "Entertainment",icon: "handbag.fill", content: {
                    TextField("Rp.", text: $accommodation)
                        .cornerRadius(8)
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

#Preview {
    DestinationSection(numberDestination: 1, transportationType: .constant("Public"))
}
