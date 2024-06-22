//
//  CustomXButton.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 21/06/2024.
//

import SwiftUI

struct CustomXButton: View {
  @Environment(\.dismiss) var dismiss
  var body: some View {
    Button {
      dismiss.callAsFunction()
    } label: {
      ZStack {
        Image(systemName: "xmark")
          .frame(width: 35, height: 35)
//          .padding(8)
          .foregroundStyle(.darkBlue)
          .font(.system(size: 10))
          .bold()
          .background(.thinMaterial)
          .clipShape(Circle())
      }
    }
  }
}

#Preview {
  CustomXButton()
}
