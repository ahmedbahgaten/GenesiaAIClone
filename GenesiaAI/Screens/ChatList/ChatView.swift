//
//  ChatView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 23/06/2024.
//

import SwiftUI

struct ChatView: View {
  @ObservedObject var model:AIModel
    var body: some View {
      HStack{
        Image(model.selectedAvatar ?? "")
          .resizable()
          .frame(width: 70,height: 70)
          .clipShape(Circle())
        VStack(alignment:.leading){
          Text(model.aiName)
            .padding(.bottom,1)
          HStack {
            Text("Hey there! It is \(model.aiName).What's up, buddy? What do you do for fun? ")
              .foregroundStyle(.gray)
              .lineLimit(1)
            Spacer()
            Text("Now")
              .foregroundStyle(.gray)
              .font(.callout)
              .fontWeight(.semibold)
          }
        }
        if model.isChatPinned {
          Image(systemName: "pin.fill")
        }
      }.padding()
    }
}

struct ChatView_Prev:PreviewProvider {
  static var previews: some View {
    let model = AIModel()
    model.aiName = "AINameTest"
    model.selectedAvatar = "5thChar"
    return ChatView(model: model)
      .previewLayout(.sizeThatFits)
  }
}
