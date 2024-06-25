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
  @State private var navigationPath = NavigationPath()
    var body: some Scene {
        WindowGroup {
          LandingScreen(path:$navigationPath)
            .environmentObject(vm)
        }
    }
}
