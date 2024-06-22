  //
  //  ChooseAINameAndGenderView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 20/06/2024.
  //

import SwiftUI

struct ChooseAINameAndGenderView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  @State private var isContinueButtonDisabled:Bool = true
  @State private var selectedGender: String? = "Female"
  
  var body: some View {
    NavigationStack {
      ZStack {
      backgroundView
        VStack {
          Text("Choose name & gender")
            .font(.system(size: 22))
            .fontWeight(.semibold)
          Spacer()
          gradientView
            .ignoresSafeArea()
        }
        VStack {
          Spacer()
            VStack {
              HStack {
                Spacer()
                TextField("Enter Name", text: $vm.userAnswers.aiName)
                  .multilineTextAlignment(.center)
                  .foregroundStyle(.white)
                  .font(.system(size: 22))
                  .fontWeight(.semibold)
                  .frame(width: 200)
                  .onChange(of: vm.userAnswers.aiName) { oldValue, newValue in
                    isContinueButtonDisabled = newValue.isEmpty
                  }
                continueButton
                  .padding(.horizontal)
                  .padding(.bottom,30)
              }
              genderButtons
            }.frame(width: 350, height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }.padding(.bottom,10)
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
  let vm = LandingFlowViewModel()
  vm.userAnswers.selectedAvatar = "6thChar"
  return ChooseAINameAndGenderView()
    .environmentObject(vm)
}

extension ChooseAINameAndGenderView {
  private var gradientView:some View {
    VStack {
      Spacer()
      Rectangle()
        .fill(Color.clear)
        .frame(height:350)
        .overlay {
          LinearGradient(
            gradient: Gradient(colors: [.darkBlue, .clear]),
            startPoint: .center,
            endPoint: .top)
        }
        .allowsHitTesting(false)
    }
  }
  private var backgroundView: some View {
    Image(vm.userAnswers.selectedAvatar ?? "")
      .resizable()
      .ignoresSafeArea()
  }
  private var genderButtons:some View {
    HStack {
      GenderButton(title: "Female",
                   isSelected: $selectedGender) {
        vm.userAnswers.aiGender = "Female"
      }
      GenderButton(title: "Male",
                   isSelected: $selectedGender) {
        vm.userAnswers.aiGender = "Male"
      }
      GenderButton(title: "Non-Binary",
                   isSelected: $selectedGender) {
        vm.userAnswers.aiGender = "Non-Binary"
      }
    }
  }
  private var continueButton: some View {
    NavigationLink {
      AIAgeView()
        .environmentObject(vm)
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.white)
          .frame(width: 30, height: 30)
        Image(systemName: "chevron.right")
          .foregroundStyle(.darkBlue)
          .font(.system(size: 15))
          .bold()
      }.opacity(isContinueButtonDisabled ? 0.4 : 1)
        .animation(.easeInOut, value: isContinueButtonDisabled)
    }.onAppear {
      if !vm.userAnswers.aiName.isEmpty {
        isContinueButtonDisabled = false
      }
    }
    .allowsHitTesting(!isContinueButtonDisabled)
  }
}


struct GenderButton: View {
  let title: String
  @Binding var isSelected: String?
  let action:() -> Void
  
  var body: some View {
    Button(action: {
      isSelected = title
      action()
    }) {
      Text(title)
        .padding()
        .frame(height:40)
        .foregroundColor(.white)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .stroke(isSelected == title ? Color.white : Color.clear)
        )
    }
  }
}
