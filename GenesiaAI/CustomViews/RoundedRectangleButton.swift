//
//  RoundedRectangleButton.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI

struct RoundedRectangleButton: View {
  let title:String
  @Binding var isDisabled:Bool
    var body: some View {
      Text(title)
        .font(.headline)
        .foregroundColor(.darkBlue)
        .padding()
        .frame(width: 300, height: 50, alignment: .center)
        .background(isDisabled ? .gray.opacity(0.5) : .white)
        .cornerRadius(20)
        .shadow(color: isDisabled ? .clear :  Color.white.opacity(0.5), radius: 10, x: 0, y: 5)
        .disabled(isDisabled)
    }
}

#Preview {
  RoundedRectangleButton(title: "Let's Start",isDisabled: .constant(false))
}
