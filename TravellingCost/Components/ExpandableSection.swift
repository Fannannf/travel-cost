//
//  ExpandableSection.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 18/03/25.
//

import SwiftUI

struct ExpandableSection<Content: View>: View {
    let title: String
    let icon: String?
    let content: Content
    @Binding var isExpanded: Bool
    
    init(title: String,icon: String? = nil, @ViewBuilder content: () -> Content, isExpanded: Binding<Bool>) {
        self.title = title
        self.icon = icon
        self.content = content()
        self._isExpanded = isExpanded
    }
    
    var body: some View {
        VStack {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                }
                Text(title)
                Spacer()
                Button(action: { isExpanded.toggle() }) {
                    Image(systemName: isExpanded ? "minus" : "plus")
                        .foregroundColor(.gray)
                }
            }
            .font(.body.bold())
            if isExpanded {
                content
            }
        }
    }
}

#Preview {
    @Previewable @State var isExpanded = false
    ExpandableSection(title: "Example", content: {
        Text("Expanded Content")
            .padding()
            .background(Color.white)
            .cornerRadius(8)
    }, isExpanded: .constant(true))
    .padding()
}
