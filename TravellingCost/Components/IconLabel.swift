//
//  IconLabel.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 24/03/25.
//

import SwiftUI

struct IconLabel: View {
    let systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .padding(5)
            .foregroundColor(.gray.opacity(0.5))
    }
}

#Preview {
    IconLabel(systemName: "house.fill")
}
