//
//  mercadolibreChallengeApp.swift
//  mercadolibreChallenge
//
//  Created by Julian Carvajal on 3/07/24.
//

import SwiftUI

@main
struct mercadolibreChallengeApp: App {
    @State private var isActive: Bool = false
    var body: some Scene {
        WindowGroup {
            if isActive {
                MeliSearcher() // Mi vista principal
            } else {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
            
        }
    }
}
