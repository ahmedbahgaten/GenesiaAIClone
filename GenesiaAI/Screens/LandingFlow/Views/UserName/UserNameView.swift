//
//  UserName.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI
import Combine

struct UserNameView: View {
  
  @State private var isDisabled:Bool = true
  @EnvironmentObject private var vm:LandingFlowViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.darkBlue
          .edgesIgnoringSafeArea(.all)
        
        VStack {
          whatIsYourNameView
          introduceYourselfView
          textFieldView
          Spacer()
          NavigationLink {
            YourPronounsView()
              .environmentObject(vm)
          } label: {
            RoundedRectangleButton(title: "Continue",
                                   isDisabled: $isDisabled)
          }
          .padding(.bottom, 40)
        }
      }
    }.navigationBarBackButtonHidden()
  }

}

#Preview {
    UserNameView()
    .environmentObject(LandingFlowViewModel())
}

extension UserNameView {
  private var whatIsYourNameView:some View {
    Text("What's your name?")
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding(.top,120)
  }
  
  private var introduceYourselfView:some View {
    Text("Introduce yourself to your friend")
      .font(.callout)
      .foregroundColor(.gray)
      .padding(.bottom, 30)
  }
  
  private var textFieldView: some View {
    ZStack {
      FirstResponderTextField(text: $vm.userAnswers.username, placeholder: "Enter your name")
        .multilineTextAlignment(TextAlignment.center)
        .textFieldStyle(PlainTextFieldStyle())
        .foregroundColor(.white)
        .onChange(of: vm.userAnswers.username) { oldValue, newValue in
          isDisabled = newValue.isEmpty
        }
    }.frame(width: 200, height: 100, alignment: .center)

  }
}
