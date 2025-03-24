//
//  PercobaanView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 18/03/25.
//

//import SwiftUI
//
//struct TripDetailsSheet: View {
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("Trip Summary")) {
//                    HStack {
//                        Text("Trip Name")
//                        Spacer()
//                        Text(viewModel.tripName.isEmpty ? "Unnamed Trip" : viewModel.tripName)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    HStack {
//                        Text("Total Destinations")
//                        Spacer()
//                        Text("\(viewModel.destinations.count)")
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    HStack {
//                        Text("Total Estimated Cost")
//                        Spacer()
//                        Text("Rp.\(viewModel.calculateTotalCost())")
//                            .foregroundColor(.red)
//                            .bold()
//                    }
//                }
//                
//                Section(header: Text("Destinations Breakdown")) {
//                    ForEach(viewModel.destinations) { destination in
//                        DestinationCostRow(destination: destination, viewModel: viewModel)
//                    }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("Trip Cost Estimate")
//            .navigationBarItems(trailing: Button("Done") {
//                dismiss()
//            })
//        }
//    }
//}
//
//struct DestinationCostRow: View {
//    let destination: DestinationModel
//    @ObservedObject var viewModel: TripEstimateViewModel
//    @State private var isExpanded: Bool = false
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Button(action: {
//                isExpanded.toggle()
//            }) {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(destination.title.isEmpty ? "Destination \(destination.index)" : destination.title)
//                            .font(.headline)
//                        Text("\(destination.transportation) - \(destination.transportationVehicle!)")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .trailing) {
//                        Text("Rp.\(viewModel.calculateTotalCost())")
//                            .foregroundColor(.red)
//                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .buttonStyle(PlainButtonStyle())
//            
//            if isExpanded {
//                Divider()
//                
//                VStack(spacing: 8) {
//                    if destination.transportation == "Public" {
//                        CostRow(label: "Transportation", value: Int(destination.price ?? 0))
//                    } else {
//                        CostRow(label: "Fuel cost (\(destination.distance ?? 0)km)", value: Int(destination.bbm ?? 0))
//                    }
//                    
//                    if let accommodation = destination.accommodation, accommodation > 0 {
//                        CostRow(label: "Accommodation", value: Int(accommodation))
//                    }
//                    
//                    if let food = destination.food, food > 0 {
//                        CostRow(label: "Food", value: Int(food))
//                    }
//                    
//                    if let entertainment = destination.entertainment, entertainment > 0 {
//                        CostRow(label: "Entertainment", value: Int(entertainment))
//                    }
//                    
//                    Divider()
//                    CostRow(label: "Subtotal", value: viewModel.calculateTotalCost(), isTotal: true)
//                }
//                .padding(.leading)
//                .padding(.top, 5)
//            }
//        }
//        .padding(.vertical, 5)
//    }
//}
//
//struct CostRow: View {
//    let label: String
//    let value: Int
//    var isTotal: Bool = false
//    
//    var body: some View {
//        HStack {
//            Text(label)
//                .font(isTotal ? .subheadline.bold() : .subheadline)
//            Spacer()
//            Text("Rp.\(value)")
//                .font(isTotal ? .subheadline.bold() : .subheadline)
//                .foregroundColor(isTotal ? .red : .secondary)
//        }
//    }
//}

import SwiftUI

struct TripDetailsSheet: View {
    
    @State var listOfStudent: [String] = ["aku","kamu","mereka","dia"]
    
    var body: some View {
        List{
            ForEach(Array(listOfStudent.enumerated()), id: \.offset){
                index, student in
                
                if index%2 == 0{
                    Text("\(index) " + student)
                        .font(.headline)
                        .foregroundStyle(.blue)
                        .onTapGesture {
                            updateList(index: index)
                        }
                }else{
                    Text("\(index) " + student)
                        .font(.headline)
                        .foregroundStyle(.red)
                        .onTapGesture {
                            updateList(index: index)
                        }
                }
            }
            
        }
    }
    
    func updateList(index:Int){
        print("asas")
        listOfStudent.remove(at: index)
    }
}


#Preview {
    TripDetailsSheet()
}
