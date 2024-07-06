//
//  SplashScreen.swift
//  mercadolibreChallenge
//
//  Created by Julian Carvajal on 6/07/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.backgroundMeli
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "hands.and.sparkles")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                Text("Mercado Libre")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Text("Búsqueda")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
    
}

#Preview {
    SplashScreen()
}
