//
//  GenesiaAIApp.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI

@main
struct GenesiaAIApp: App {
  @StateObject private var vm = LandingFlowViewModel()
    var body: some Scene {
        WindowGroup {
          if Prefs.isLandingScreenByPassed {
            UserNameView()
              .environmentObject(vm)
          }else {
            LandingScreen()
          }
        }
    }
}
