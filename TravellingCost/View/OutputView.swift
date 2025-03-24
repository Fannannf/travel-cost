//
//  OutputView.swift
//  TravellingCost
//
//  Created by Zhafira Zahra on 24/03/25.
//

import SwiftUI

struct OutputView: View {
    var body: some View {
        ScrollView{
            VStack {
                Text("Total Jawa Trip")
                    .font(.title)
                    .padding(.top)
                    .foregroundColor(.reddow.opacity(0.7))
                Text("Rp. 15.000.000")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red.opacity(0.8))
                DestinationOutput()
                DestinationOutput()
            }
            .padding()
        }
        .background(Color(.white))
    }
}

#Preview {
    OutputView()
}
