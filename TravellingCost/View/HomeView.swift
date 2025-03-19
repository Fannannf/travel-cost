//
//  HomeView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 17/03/25.
//

import SwiftUI

struct HomeView: View {
    @State private var tripName: String = ""
    @State private var destinations: [Int] = [1]
    
    var body: some View {
        NavigationView {
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
                            let newDestination = (destinations.last ?? 0) + 1
                            destinations.append(newDestination)
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
                                TextField("Placeholder", text: $tripName)
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
                            
                            ScrollView{
                                VStack(spacing: 16){
                                    ForEach(destinations, id: \.self) { index in
                                        DestinationSection(numberDestination: index)
                                    }
                                    
                                    Button(action: {
                                        print("Calculate tapped")
                                    }) {
                                        Text("Calculate")
                                            .frame(maxWidth: .infinity)
                                            .font(.headline)
                                            .padding()
                                            .background(Color(.red).opacity(0.7))
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
        }
    }
}
#Preview {
    HomeView()
}
