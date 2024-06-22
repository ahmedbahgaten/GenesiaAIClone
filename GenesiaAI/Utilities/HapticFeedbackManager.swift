//
//  HapticFeedbackManager.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 21/06/2024.
//

import Foundation
import UIKit

class HapticFeedbackManager {
  static let shared = HapticFeedbackManager()
  
  private init() {}
  
  func triggerImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
  }
  
  func triggerNotificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
  }
  
  func triggerSelectionFeedback() {
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
  }
}
