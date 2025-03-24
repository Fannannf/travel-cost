//
//  DestinationOutput.swift
//  TravellingCost
//
//  Created by Zhafira Zahra on 24/03/25.
//

import SwiftUI

struct DestinationOutput: View {
    var body: some View {
        VStack{
            VStack(spacing: 12){
                HStack{
                    Text("Klaten").font(.title2).fontWeight(.bold).foregroundStyle(Color.reddow)
                    Spacer()
                }
                .padding(.bottom)
                
                HStack{
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                    Text("Accommodation")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("Rp. 1.000.000")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                
                HStack{
                    Image(systemName: "car.rear.and.tire.marks")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                    Text("Transportation")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("Rp. 1.500.000")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                
                HStack{
                    Image(systemName: "fork.knife")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                    Text("Food")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Spacer()
                    Text("Rp. 2.000.000")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                
                HStack{
                    Image(systemName: "handbag.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                    Text("Entertainment")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Spacer()
                    Text("Rp. 2.000.000")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                
                HStack{
                    Image(systemName: "banknote.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(.red.opacity(0.8))
                    Text("Emergency Fund")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Spacer()
                    Text("Rp. 1.000.000")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                
                HStack{
                    Spacer()
//                    Text("Total :")
//                        .font(.title3)
//                        .fontWeight(.medium)
//                        .foregroundStyle(Color.reddow)
                    Text("Rp. 7.500.000")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.reddow)
                    
                }
                .padding(.top)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(color: Color("shadowColor"), radius: 6,y: 5)
        }
        .padding(.bottom)
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color(.greyish))
    }
}

#Preview {
    DestinationOutput()
}
