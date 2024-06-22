  //
  //  ChoosePersonalityGridItemView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 21/06/2024.
  //

import SwiftUI

struct ChoosePersonalityGridItemView:View {
  @StateObject var userAnswers:UserAnswers
  var title:String
  var width:CGFloat
  
  var body: some View {
    Text(title)
      .foregroundColor(.white)
      .lineLimit(3)
      .multilineTextAlignment(.center)
      .frame(width: width,height: 120)
      .font(.system(size: 18))
      .background(
        userAnswers.selectedPersonality == title ?  Color.white.opacity(0.2) : Color.white.opacity(0.1)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(userAnswers.selectedPersonality == title ? Color.white : Color.gray.opacity(0.3))
      }
      .padding(.vertical,8)
      .animation(.bouncy, value: userAnswers.selectedPersonality)
      .onTapGesture {
        userAnswers.selectedPersonality = title
      }
  }
}

#Preview {
  ChoosePersonalityGridItemView(userAnswers: UserAnswers(),
                                title: "Test",
                                width: 200)
}
