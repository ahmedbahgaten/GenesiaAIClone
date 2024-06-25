//
//  UserName.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI
import Combine

enum UserNamePushedFrom:Hashable {
  case landing
  case startNewChat
}

@MainActor
struct UserNameView: View {
  
  @State private var isContinueButtonDisabled:Bool = true
  @Binding var isFromStartNewChat:Bool
  @EnvironmentObject private var vm:LandingFlowViewModel
  @State private var text:String = ""
  @FocusState private var isFocused: Bool
  @Binding var path:NavigationPath
  
  var body: some View {
      ZStack {
        Color.darkBlue
          .edgesIgnoringSafeArea(.all)
        
        VStack {
          whatIsYourNameView
          introduceYourselfView
          textFieldView
          Spacer()
          RoundedRectangleButton(title: "Continue",
                                 titleColor: .darkBlue,
                                 isDisabled: $isContinueButtonDisabled)
          .onTapGesture {
            path.append("YourPronounsView")
          }
          .allowsHitTesting(!isContinueButtonDisabled)
          .padding(.bottom, 40)
        }
      }.navigationBarBackButtonHidden()
      .toolbar {
        if isFromStartNewChat {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton()
          }
        }
      }
      .onAppear {
        isContinueButtonDisabled = vm.userAnswers.username.isEmpty
        text = vm.userAnswers.username
        isFocused.toggle()
      }
  }
}

#Preview {
  UserNameView(isFromStartNewChat: .constant(false),path: .constant(NavigationPath()))
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
      TextField("", text: $text,
                prompt: Text("Enter your name").foregroundColor(.gray))
      .multilineTextAlignment(.center)
      .font(.system(size: 25))
      .keyboardShortcut(.end)
      .focused($isFocused)
      .foregroundStyle(.white)
        .onChange(of: text) { oldValue, newValue in
          vm.userAnswers.username = newValue
          withAnimation {
            isContinueButtonDisabled = newValue.isEmpty
          }
        }
        .onSubmit {
          guard !vm.userAnswers.username.isEmpty else { return }
        }
    }.frame(width: 200, height: 100, alignment: .center)

  }
}
