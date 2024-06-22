//
//  YourPronounsView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI

struct YourPronounsView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  
    var body: some View {
      NavigationStack {
        ZStack {
          Color.darkBlue
            .edgesIgnoringSafeArea(.all)
          VStack(spacing: 5) {
            yourPronounsView
            subTitleView
            pickerView
            Spacer()
            continueButton
          }
        }.onAppear {
          print(vm.userAnswers.username)
        }
      }.navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement:.topBarLeading) {
            CustomBackButton()
          }
        }
    }
}

#Preview {
  YourPronounsView()
    .environmentObject(LandingFlowViewModel())
}
extension YourPronounsView {
  private var yourPronounsView:some View {
    Text("Your pronouns")
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding(.top,120)
  }
  
  private var subTitleView:some View {
    Text("Which pronoun would you like your friend to call you?")
      .font(.callout)
      .foregroundColor(.gray)
      .frame(width: 300, height: 50, alignment: .center)
      .multilineTextAlignment(.center)
      .opacity(0.8)
      .padding(.bottom, 30)
  }
  
  private var pickerView:some View {
    Picker(selection: $vm.userAnswers.userPronouns, label: Text("Picker")) {
      Text("She/Her").tag("She/Her")
      Text("He/Him").tag("He/Him")
      Text("They/Them").tag("They/Them")
    }.pickerStyle(WheelPickerStyle())
      .frame(width: 300, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
  }
  
  private var continueButton:some View {
    NavigationLink {
      DateOfBirthView()
        .environmentObject(vm)
    } label: {
      RoundedRectangleButton(title: "Continue", isDisabled: .constant(false))
        .padding(.bottom,40)
    }
  }
}
