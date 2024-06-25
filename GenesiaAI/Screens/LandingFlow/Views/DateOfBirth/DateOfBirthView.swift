//
//  DateOfBirthView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import SwiftUI

struct DateOfBirthView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  @State private var DOB:Date = .now
  @Binding var path:NavigationPath

  var dateClosedRange: ClosedRange<Date> {
    let min = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    let max = Date()
    return min...max
  }
  
    var body: some View {
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
    DateOfBirthView(path: .constant(NavigationPath()))
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
    
    DatePicker("", selection: $DOB,
               in: dateClosedRange,displayedComponents: [.date])
      .datePickerStyle(WheelDatePickerStyle())
      .preferredColorScheme(.dark)
      .frame(width: 300, height: 200, alignment: .center)
      .onChange(of: DOB) { oldValue, newValue in
        vm.userAnswers.dateOfBirth = newValue
      }
  }
  
  private var continueButton:some View {
    RoundedRectangleButton(title: "Continue", titleColor: .darkBlue, isDisabled: .constant(false))
      .padding(.bottom,40)
      .onTapGesture {
        path.append("Interests")
      }
  }
}
