//
//  BlurryBackgroundView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 23/06/2024.
//

import Foundation
import SwiftUI

struct BackgroundBlur: UIViewRepresentable {
  let style: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
    return effectView
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    uiView.effect = UIBlurEffect(style: style)
  }
}
