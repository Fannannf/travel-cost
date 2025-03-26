//
//  HistoryView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 25/03/25.
//

import SwiftUI
import SwiftData
import Lottie

struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var trips: [TripModel]
    @Binding var shouldResetData: Bool
    
    var body: some View {
        NavigationStack {
            if trips.isEmpty {
                VStack {
                    LottieView(animation: .named("emptyTripHistory"))
                        .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                        .frame(width: 200, height: 200)
                    Text("Your trip history is empty! Start planning your next adventure now.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .frame(width: 300)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
            } else {
                List {
                    ForEach(trips) { trip in
                        NavigationLink(destination: TripDetailView(trip: trip)) {
                            VStack(alignment: .leading) {
                                Text(trip.nameTrip)
                                    .font(.headline)
                                Text("\(trip.destination.count) destinations")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteTrip)
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Trip History")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            shouldResetData = true
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.blue)
                                Text("Back")
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteTrip(at offsets: IndexSet) {
        for index in offsets {
            let tripToDelete = trips[index]
            context.delete(tripToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting trip: \(error.localizedDescription)")
        }
    }
}


#Preview {
    HistoryView(shouldResetData: .constant(true))
}
