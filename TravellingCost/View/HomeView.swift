//
//  HomeView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 17/03/25.
//

import SwiftUI
import SwiftData
import Lottie

struct HomeView: View {
    @StateObject var viewModel = TripEstimateViewModel()
    @Environment(\.modelContext) private var context
    @State private var showingResult = false
    @State private var shouldResetData = false
    @State private var showOutputView = false
    @State private var navigateToHistory = false
    @State private var totalCost = 0
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.indigo.ignoresSafeArea()
                
                VStack(spacing: 0){
                    HStack {
                        Image(systemName: "suitcase.rolling.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("BudgeTrip")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        NavigationLink(destination: HistoryView(shouldResetData: $shouldResetData)){
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.indigo)
                    
                    ZStack{
                        Color(.systemGray6)
                            .cornerRadius(20, corners: [.topLeft, .topRight])
                            .ignoresSafeArea(edges: .bottom)
                        VStack{
                            VStack(alignment: .leading) {
                                Label("Trip Name", systemImage: "")
                                    .font(.title2.bold())
                                TextField("Enter trip name", text: $viewModel.tripName)
                                    .padding(10)
                                    .padding(.leading, 15)
                                    .font(.body.bold())
                                    .overlay(
                                        Text("*")
                                            .foregroundColor(.red)
                                            .font(.title)
                                            .padding(.leading, 7),
                                        alignment: .leading
                                    )
                                    .cornerRadius(8)
                                Divider()
                                    .background(Color(.systemBackground))
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(15)
                            
                            VStack{
                                HStack{
                                    Text("Destination")
                                        .font(.title3.bold())
                                    Spacer()
                                    Button(action: {
                                        viewModel.addDestination()
                                    }, label: {
                                        HStack{
                                            Text("Add")
                                                .font(.title3)
                                            Image(systemName: "plus")
                                                .font(.title2)
                                        }
                                        .tint(.indigo)
                                    })
                                }
                                .padding(.horizontal,5)
                            }
                            .padding(.top,10)
                            
                            ScrollView(showsIndicators: false){
                                VStack(spacing: 16){
                                    ForEach(viewModel.destinations) { destination in
                                        DestinationSection(viewModel: viewModel, destinationId: destination.id)
                                    }
                                    .padding(.top, 5)
                                    Button(action: {
                                        showOutputView.toggle()
                                    }, label: {
                                        Text("Calculate")
                                            .frame(maxWidth: .infinity)
                                            .font(.headline)
                                            .padding()
                                            .background(viewModel.isCalculateDisabled ? Color.gray.opacity(0.5) : Color.indigo.opacity(0.8))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    })
                                    .disabled(viewModel.isCalculateDisabled)
                                    .padding(.top)
                                }
                            }
                            .padding(.top,5)
                        }
                        .padding()
                        .padding(.top,5)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .hideKeyboardWhenTappedAround()
            .onAppear(){
                if shouldResetData {
                    resetData()
                    shouldResetData = false
                }
            }
            .navigationDestination(isPresented: $navigateToHistory) {
                    HistoryView(shouldResetData: $shouldResetData)
                }
        }
        .sheet(isPresented: $showOutputView) {
            OutputView(viewModel:viewModel,showOutputView: $showOutputView, shouldResetData: $shouldResetData,navigateToHistory: $navigateToHistory)
        }
    }
    private func resetData() {
        viewModel.tripName = ""
        viewModel.destinations.removeAll()
        viewModel.addDestination()
        totalCost = 0
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension View {
    func hideKeyboardWhenTappedAround() -> some View {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
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
