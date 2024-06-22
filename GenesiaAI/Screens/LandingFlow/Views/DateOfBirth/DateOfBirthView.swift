//
//  DateOfBirthView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI

struct DateOfBirthView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  
    var body: some View {
      NavigationStack {
        ZStack {
          Color.darkBlue
            .edgesIgnoringSafeArea(.all)
          VStack(spacing: 5) {
            yourDateOfBirthView
            subTitleView
            datePickerView
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

struct DateOfBirth_Preiew:PreviewProvider {
  static var previews: some View {
    DateOfBirthView()
      .environmentObject(LandingFlowViewModel())
  }
}

extension DateOfBirthView {
  private var yourDateOfBirthView:some View {
    Text("Your date of birth")
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding(.top,120)
  }
  
  private var subTitleView:some View {
    Text("Knowing your date of birth makes your experience more relevant")
      .font(.callout)
      .foregroundColor(.gray)
      .frame(width: 300, height: 50, alignment: .center)
      .multilineTextAlignment(.center)
      .opacity(0.8)
      .padding(.bottom, 30)
  }
  
  private var datePickerView:some View {
    DatePicker("", selection: $vm.userAnswers.dateOfBirth,displayedComponents: .date)
      .datePickerStyle(WheelDatePickerStyle())
      .frame(width: 300, height: 200, alignment: .center)
  }
  
  private var continueButton:some View {
    NavigationLink {
      InterestsView()
        .environmentObject(vm)
    } label: {
      RoundedRectangleButton(title: "Continue", isDisabled: .constant(false))
        .padding(.bottom,40)
    }
  }
}
