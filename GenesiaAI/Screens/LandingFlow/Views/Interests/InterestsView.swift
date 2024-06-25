//
//  InterestsView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 20/06/2024.
//

import SwiftUI

struct InterestsView: View {
  @EnvironmentObject var vm:LandingFlowViewModel  
  @State private var isContinueButtonDisabled:Bool = true
  @State private var selectedInterests:[String] = []
  @Binding var path:NavigationPath
  
  var body: some View {
      ZStack {
        Color.darkBlue
          .edgesIgnoringSafeArea(.all)
        VStack(spacing: 5) {
          yourInterestsView
          subTitleView
          Spacer()
          interestsGridView
          Spacer()
          continueButton
        }
      }.navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement:.topBarLeading) {
          CustomBackButton()
        }
      }
      .onAppear {
        isContinueButtonDisabled = selectedInterests.isEmpty
      }.onChange(of: selectedInterests) { oldValue, newValue in
        vm.userAnswers.interests = newValue
      }
  }
}

#Preview {
  InterestsView(path: .constant(NavigationPath()))
    .environmentObject(LandingFlowViewModel())
}
extension InterestsView {
  private var yourInterestsView: some View {
    Text("Your interests")
      .font(.largeTitle)
      .foregroundColor(.white)
  }
  
  private var subTitleView:some View {
    Text("Your 5 interests to enhance your conversations")
      .font(.subheadline)
      .foregroundColor(.gray)
      .opacity(0.8)
      .padding(.bottom, 30)
  }
  
  private var interestsGridView:some View {
    ScrollView {
      TagView(tags: vm.interests,
              noSelectedItems: $isContinueButtonDisabled, selectedInterests: $selectedInterests)
      .padding(.bottom,50)
    }.overlay {
      gradientView
    }
    .scrollIndicators(.hidden)
  }
  
  private var gradientView: some View {
    VStack {
      Spacer()
      Rectangle()
        .fill(Color.clear)
        .frame(height: 100)
        .overlay {
          LinearGradient(
            gradient: Gradient(colors: [.darkBlue, .clear]),
            startPoint: .bottom,
            endPoint: .top)
        }
        .allowsHitTesting(false)
    }
  }
  
  private var continueButton:some View {
    RoundedRectangleButton(title: "Continue",
                           titleColor: .darkBlue,
                           isDisabled: $isContinueButtonDisabled)
    .padding(.bottom,40)
    .disabled(isContinueButtonDisabled)
    .onTapGesture {
      path.append("ChooseYourAIFriendScreen")
    }
  }
}
