//
//  YourPronounsView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI

struct YourPronounsView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  @State private var pronouns:String = "He/Him"
  private let userPronouns = ["She/Her","He/Him","They/Them"]
  @Binding var path:NavigationPath
  
    var body: some View {
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
        }.navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement:.topBarLeading) {
            CustomBackButton()
          }
        }
    }
}

#Preview {
  YourPronounsView(path: .constant(NavigationPath()))
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
    Picker(selection: $pronouns, label: Text("Picker")) {
      ForEach(userPronouns,id:\.self) { pronoun in
        Text(pronoun).tag(pronoun)
      }
    }
    .pickerStyle(.wheel)
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
      .frame(width: 300, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .onChange(of: pronouns) { oldValue, newValue in
        vm.userAnswers.userPronouns = newValue
      }
  }
  
  private var continueButton:some View {
    RoundedRectangleButton(title: "Continue",
                           titleColor: .darkBlue,
                           isDisabled: .constant(false))
    .padding(.bottom,40)
    .onTapGesture {
      path.append("DateOfBirthView")
    }
  }
}
