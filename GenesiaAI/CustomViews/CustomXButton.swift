//
//  CustomXButton.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 21/06/2024.
//

import SwiftUI

struct CustomXButton: View {
  var body: some View {
    ZStack {
      Image(systemName: "xmark")
        .frame(width: 35, height: 35)
        .foregroundStyle(.darkBlue)
        .font(.system(size: 10))
        .bold()
        .background(.ultraThinMaterial)
        .clipShape(Circle())
    }
  }
}

#Preview {
  CustomXButton()
}
