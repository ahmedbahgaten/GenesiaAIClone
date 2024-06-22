//
//  AIAgeView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 21/06/2024.
//

import SwiftUI

struct AIAgeView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  
    var body: some View {
      NavigationStack {
        ZStack {
          Color.darkBlue
            .edgesIgnoringSafeArea(.all)
          
          VStack {
            aiAgeView
            subheadline
            agePickerView
            Spacer()
            NavigationLink {
              ChoosePersonalityView()
                .environmentObject(vm)
            } label: {
              RoundedRectangleButton(title: "Continue",
                                     isDisabled:.constant(false))
            }
            .padding(.bottom, 40)
          }
        }
      }.navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton()
          }
        }
    }
}

#Preview {
    AIAgeView()
    .environmentObject(LandingFlowViewModel())
}

extension AIAgeView {
  private var aiAgeView:some View {
    Text("\(vm.userAnswers.aiName)'s Age")
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding(.top,120)
  }
  
  private var subheadline:some View {
    Text("You can get a more intimate experience by choosing the age")
      .font(.subheadline)
      .foregroundColor(.gray)
      .padding(.bottom, 30)
      .frame(width: 250)
      .multilineTextAlignment(.center)
  }
  
  private var agePickerView: some View {
    VStack {
      Picker(selection: $vm.userAnswers.aiAge, label: Text("Picker")) {
        ForEach(Array(stride(from: 99, through: 18, by: -1)), id: \.self) { index in
          Text(index.description).tag(index)
        }
      }.pickerStyle(WheelPickerStyle())
        .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
  }
}
