//
//  Prefs.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import Foundation
enum Prefs {
  private static var UD: UserDefaults { UserDefaults.standard }
  
  static var isLandingScreenByPassed: Bool {
    get { UD.bool(forKey: Keys.isLandingScreenByPassed) }
    set { UD.set(newValue, forKey: Keys.isLandingScreenByPassed) }
  }
}

extension Prefs {
  private enum Keys {
    static let isLandingScreenByPassed = "isLandingScreenByPassed"
  }
}
