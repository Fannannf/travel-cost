//
//  SplashScreenView.swift
//  TravellingCost
//
//  Created by Muhamad Fannan Najma Falahi on 17/03/25.
//

import SwiftUI
import Lottie

struct SplashScreenView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @State var isActive: Bool = false
    @State private var fadeIn = false
    @State private var scale: CGFloat = 0.0
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.3), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            if self.isActive{
                HomeView()
            }else{
                LottieView(animation: .named("logoTravel"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 15)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.spring(response: 1.0, dampingFraction: 0.6, blendDuration: 0.5)) {
                            scale = 1.0
                        }
                    }
            }
        }.onAppear {
            withAnimation {
                self.fadeIn = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
