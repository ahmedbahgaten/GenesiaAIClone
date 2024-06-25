//
//  ChatView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 23/06/2024.
//

import SwiftUI

struct ChatView: View {
  var aiName:String
  var aiAvatar:String
    var body: some View {
      HStack{
        Image(aiAvatar)
          .resizable()
          .frame(width: 70,height: 70)
          .clipShape(Circle())
          .padding(.horizontal)
        VStack(alignment:.leading){
          Text(aiName)
            .padding(.bottom,1)
          HStack {
            Text("Hey there! It is \(aiName).What's up, buddy? What do you do for fun? ")
              .foregroundStyle(.gray)
              .lineLimit(1)
            Spacer()
            Text("Now")
              .foregroundStyle(.gray)
              .font(.callout)
              .fontWeight(.semibold)
          }
        }
      }.padding()
    }
}

struct ChatView_Prev:PreviewProvider {
  static var previews: some View {
    ChatView(aiName: "AINameTest", aiAvatar: "5thChar")
      .previewLayout(.sizeThatFits)
  }
}
