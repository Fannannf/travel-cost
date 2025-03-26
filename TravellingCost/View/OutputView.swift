//
//  OutputView.swift
//  TravellingCost
//
//  Created by Zhafira Zahra on 24/03/25.
//

import SwiftUI

struct OutputView: View {
    @StateObject var viewModel = TripEstimateViewModel()
    @Environment(\.modelContext) private var context
    @State private var isNavigating = false
    @Binding var showOutputView: Bool
    @Binding var shouldResetData: Bool
    @Binding var navigateToHistory: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    Text("Total \(viewModel.tripName) Trip")
                        .font(.title.bold())
                        .padding(.top)
                    Text("\(viewModel.calculateTotalCost())")
                        .font(.largeTitle.bold())
                        .padding(.top,2)
                    ForEach(viewModel.destinations) { destination in
                        DestinationOutput(viewModel: viewModel, destinationId: destination.id)
                    }
                    .padding(.top, 5)
                }
                .padding()
            }
            .navigationBarTitle("Total Calculate", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.showOutputView = false
                }){
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }.foregroundStyle(.indigo)
                },
                trailing: Button(action: {
                    viewModel.saveTrip(context: context)
                    shouldResetData = false
                    isNavigating = true
                    navigateToHistory = true
                    dismiss()
                }) {
                    Text("Save")
                        .foregroundStyle(.indigo)
                })
            .background(Color(.systemGray6))
        }
        
    }
}

#Preview {
    OutputView(showOutputView: .constant(true), shouldResetData: .constant(true),navigateToHistory: .constant(true))
}
