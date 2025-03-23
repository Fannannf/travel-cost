//
//  HomeView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 17/03/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TripEstimateViewModel()
    @State private var showingResult = false
    @State private var totalCost = 0
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.red.ignoresSafeArea()
                
                VStack(spacing: 0){
                    HStack {
                        Image(systemName: "hexagon.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Trip Estimate")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                        }, label: {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.title2)
                                .foregroundColor(.white)
                        })
                        Button(action: {
                            viewModel.addDestination()
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                        })
                    }
                    .padding()
                    .background(Color.red)
                    
                    ZStack{
                        Color.white
                            .cornerRadius(20, corners: [.topLeft, .topRight])
                            .ignoresSafeArea(edges: .bottom)
                        VStack{
                            VStack(alignment: .leading) {
                                Label("Name Trip", systemImage: "")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                TextField("Placeholder", text: $viewModel.tripName)
                                    .padding(10)
                                    .background(Color(.white))
                                    .cornerRadius(8)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.red, Color.red.opacity(0.6)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(15)
                            
                            ScrollView(showsIndicators: false){
                                VStack(spacing: 16){
                                    ForEach(viewModel.destinations) { destination in
                                        DestinationSection(viewModel: viewModel, destinationId: destination.id)
                                    }
                                    
                                    Button(action: {
                                        totalCost = viewModel.calculateTotalCost()
                                        showingResult = true
                                    }) {
                                        Text("Calculate")
                                            .frame(maxWidth: .infinity)
                                            .font(.headline)
                                            .padding()
                                            .background(Color(.red).opacity(0.8))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .padding()
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                        .padding(.top,5)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .sheet(isPresented: $showingResult) {
                TripDetailsSheet(viewModel: viewModel)
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    HomeView()
}
