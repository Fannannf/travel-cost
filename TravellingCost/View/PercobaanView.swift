//
//  PercobaanView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 18/03/25.
//

import SwiftUI

struct PercobaanView: View {
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            VStack(spacing:0){
                HStack {
                    // Logo
                    Image(systemName: "hexagon.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text("MY CARD")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    // Notification bell
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.red)
                
                ZStack {
                    Color.white
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .ignoresSafeArea(edges: .bottom)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Hello,")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                    
                                    Text("Yuliia Mei")
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                                
                                // User avatar
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            
                            PaymentCardView(
                                iconName: "briefcase",
                                sender: "Myakinkov Maxim",
                                category: "Electronic devices",
                                location: "Kyiv, Dept. №756",
                                amount: "",
                                isLocked: true,
                                isDarkMode: false
                            )
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct PaymentCardView: View {
    let iconName: String
    let sender: String
    let category: String
    let location: String
    let amount: String
    let isLocked: Bool
    let isDarkMode: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: iconName)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("from \(sender)")
                        .font(.subheadline)
                        .foregroundColor(isDarkMode ? .gray : .gray)
                    
                    Text(category)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                
                Spacer()
                
                if isLocked {
                    Image(systemName: "lock.fill")
                        .foregroundColor(isDarkMode ? .white : .gray)
                }
            }
            
            // Status
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                
                Text("Waiting for the recipient")
                    .font(.caption)
                    .foregroundColor(isDarkMode ? Color.gray : Color.red)
                
                Spacer()
            }
            
            Text(location)
                .font(.caption)
                .foregroundColor(isDarkMode ? .gray : .gray)
            
            // Payment button
            if !amount.isEmpty {
                HStack {
                    Text("Pay")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black)
                    
                    Spacer()
                    
                    Text("$ \(amount)")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(isDarkMode ? Color(UIColor.darkGray) : Color.white)
        .cornerRadius(12)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    PercobaanView()
}
