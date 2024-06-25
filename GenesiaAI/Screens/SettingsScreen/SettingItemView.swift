//
//  SettingItemView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 23/06/2024.
//

import SwiftUI

struct SettingItemView<Content: View>: View {
  let title: String
  let content: Content
  var titleColor:Color
  
  init(title: String,
       titleColor:Color = .white,
       @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
    self.titleColor = titleColor
  }
  
  var body: some View {
    HStack {
      Text(title)
        .foregroundStyle(titleColor)
        .font(.system(size: 18))
        .fontWeight(.semibold)
        .lineLimit(1)
      Spacer()
      content
        .padding(.horizontal)
    }
    .padding()
    .frame(height: 60)
    .background(Color.gray.opacity(0.2))
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

#Preview {
  SettingItemView(title: "test") {
    Text("Test")
  }
}
