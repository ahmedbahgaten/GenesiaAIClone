  //
  //  ChoosePersonality.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 21/06/2024.
  //

import SwiftUI

struct ChoosePersonalityView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.darkBlue
        VStack {
          choosePersonalityView
            .padding(.top,70)
          subheadline
          personalitiesView
          NavigationLink {
            AppSubscriptionView()
              .environmentObject(vm)
          }label: {
            RoundedRectangleButton(title: "Create Your AI Friend", isDisabled: .constant(false))
              .padding(.bottom,70)
          }
        }
      }.ignoresSafeArea()
    }.navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton()
        }
      }
      .onAppear {
        dump(vm.userAnswers)
      }
  }
}

#Preview {
  ChoosePersonalityView()
    .environmentObject(LandingFlowViewModel())
}
extension ChoosePersonalityView {
  private var choosePersonalityView:some View {
    Text("Choose Personality")
      .font(.system(size: 22))
      .fontWeight(.semibold)
  }
  
  private var subheadline:some View {
    Text("Characterstics of your AI Friend")
      .font(.subheadline)
      .foregroundColor(.gray)
      .padding(.bottom, 30)
      .frame(width: 250)
      .multilineTextAlignment(.center)
  }
  
  private var personalitiesView:some View {
    GeometryReader { geometry in
      ScrollView {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
          ForEach(vm.aiPersonalities,id:\.self){ item in
            gridItem(item: item,
                     width: (geometry.size.width - 55) / 2)
          }
        }
      }.padding(.horizontal)
        .scrollIndicators(.hidden)
    }
  }
  
  private func gridItem(item:String,width:CGFloat) -> some View {
    ChoosePersonalityGridItemView(userAnswers: vm.userAnswers,
                                  title: item,
                                  width: width)
  }
}
