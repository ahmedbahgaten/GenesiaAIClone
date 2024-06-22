//
//  ChatListView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 22/06/2024.
//

import SwiftUI

struct ChatListView: View {
    var body: some View {
      ZStack {
        Color.darkBlue
        VStack {
          headerView
          Spacer()
          RoundedRectangleButton(title: "Start New Chat",
                                 isDisabled: .constant(false))
        }.padding(.vertical,80)
      }.ignoresSafeArea()
    }
}

#Preview {
    ChatListView()
}

extension ChatListView {
  private var headerView:some View {
    HStack {
      Text("Genesia AI")
        .font(.largeTitle)
      Spacer()
      ZStack {
        HStack {
          Image(systemName: "star.fill")
          Text("PRO")
            .bold()
        }.shadow(color: .white, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
          .padding(10)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.white)
          )
      }.padding(.horizontal,10)
      Image(systemName: "gearshape.fill")
        .foregroundStyle(.gray)
        .font(.system(size: 20))
    }.padding(.horizontal,30)
  }
}
