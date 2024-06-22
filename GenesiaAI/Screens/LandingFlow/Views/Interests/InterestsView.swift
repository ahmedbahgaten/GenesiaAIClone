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

  
  var body: some View {
    NavigationStack {
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
    InterestsView()
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
              noSelectedItems: $isContinueButtonDisabled)
        .padding(.bottom,50)
    }.overlay {
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
  }
  
  private var continueButton:some View {
    NavigationLink {
      vm.setUserInterests()
      return ChooseYourAIFriendView()
        .environmentObject(vm)
    } label: {
      RoundedRectangleButton(title: "Continue", isDisabled: $isContinueButtonDisabled)
        .padding(.bottom,40)
    }.disabled(isContinueButtonDisabled)
  }
}
