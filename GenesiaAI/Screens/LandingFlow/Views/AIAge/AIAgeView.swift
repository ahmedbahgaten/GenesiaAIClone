//
//  AIAgeView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 21/06/2024.
//

import SwiftUI

struct AIAgeView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  @State private var aiAge:Int = 0
  @Binding var path:NavigationPath
  
  let maxAge = 99
  let minAge = 18
    var body: some View {
        ZStack {
          Color.darkBlue
            .edgesIgnoringSafeArea(.all)
          
          VStack {
            aiAgeView
            subheadline
            agePickerView
            Spacer()
            RoundedRectangleButton(title: "Continue",
                                   titleColor: .darkBlue,
                                   isDisabled:.constant(false))
            .padding(.bottom, 40)
            .onTapGesture {
              path.append("ChoosePersonalityView")
            }
          }
        }.navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton()
          }
        }
        .onAppear {
          aiAge = minAge
        }
    }
}

#Preview {
  AIAgeView(path: .constant(NavigationPath()))
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
      Picker(selection: $aiAge, label: Text("Picker")) {
        ForEach(Array(stride(from: maxAge, through: minAge, by: -1)), id: \.self) { index in
          Text(index.description).tag(index)
        }
      }.preferredColorScheme(.dark)
      .pickerStyle(WheelPickerStyle())
        .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onChange(of: aiAge) { oldValue, newValue in
          vm.userAnswers.aiAge = newValue
        }
    }
  }
}
