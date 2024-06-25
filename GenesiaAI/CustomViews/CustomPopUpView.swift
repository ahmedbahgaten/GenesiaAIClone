//
//  CustomPopUpView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 23/06/2024.
//

import SwiftUI

struct CustomPopUpView<PrimaryButton: View, SecondaryButton: View>: View {
  let title:String
  let message:String
  let primaryButton:PrimaryButton
  let secondaryButton:SecondaryButton
  
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack(spacing: 25){
          VStack(spacing:10) {
            Text(title)
              .font(.system(size: 22))
              .fontWeight(.semibold)
              .foregroundStyle(.white)
            Text(message)
              .multilineTextAlignment(.center)
              .font(.system(size: 15))
              .foregroundStyle(.gray)
          }
          VStack(spacing:10) {
            primaryButton
            secondaryButton
          }
        }.padding()
          .background(
            RoundedRectangle(cornerRadius: 25)
              .foregroundStyle(.darkBlue)
          )
      }.ignoresSafeArea()
        .frame(width: geometry.size.width, height: geometry.size.height)

    }
  }
}

#Preview {
  CustomPopUpView(title: "Are you sure?", message: "All of your data and AI Characters will be erased permanantely", primaryButton: Button("Reset Data"){
    
  }, secondaryButton: Button("Cancel"){} )
}
