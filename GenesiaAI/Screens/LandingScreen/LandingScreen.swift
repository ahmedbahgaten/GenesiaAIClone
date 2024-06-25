  //
  //  ContentView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 19/06/2024.
  //

import SwiftUI
struct LandingScreen: View {
  @EnvironmentObject var vm: LandingFlowViewModel
  let imageNames = ["1stChar",
                    "2ndChar",
                    "3rdChar",
                    "4thChar"]
  
  @State private var currentIndex = 0
  @State private var showPrivacyPolicy = false
  @State private var showTermsOfService = false
  @State private var scale: CGFloat = 1.0
  @Binding var path:NavigationPath
  
  var body: some View {
    NavigationStack(path: $path) {
      VStack(alignment: .center) {
        titleHeader
        Spacer()
        infoView
        letsStartButton
        termsAndPolicyView
      }
      .navigationDestination(for: String.self, destination: { screen in
        destinationView(screen: screen)
      })
      .navigationDestination(for: UserNamePushedFrom.self, destination: { pushedFrom in
        userNameView(pushedFrom: pushedFrom)
      })
      .navigationDestination(for: AIModel.self, destination: { model in
        let vm = ChatViewViewModel(aiModel: model)
        ChatViewScreen(vm: vm,
                       path: $path)
      })
      .navigationBarBackButtonHidden()
      .background {
        backgroundView
      }
      .sheet(isPresented: $showTermsOfService, content: {
        TermsOfService()
      })
      .sheet(isPresented: $showPrivacyPolicy, content: {
        PrivacyPolicy()
      })
    }
  }
  
  private func startScalingAnimation() {
    withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
      scale = 1.1
    }
  }
  
  @ViewBuilder
  private func destinationView(screen:String) -> some View {
    if screen == "YourPronounsView" {
      YourPronounsView(path: $path)
        .environmentObject(vm)
    }else if screen == "DateOfBirthView" {
      DateOfBirthView(path: $path)
        .environmentObject(vm)
    }else if screen == "Interests" {
      InterestsView(path:$path)
        .environmentObject(vm)
    }else if screen == "ChooseYourAIFriendScreen" {
      ChooseYourAIFriendView(path:$path)
        .environmentObject(vm)
    }else if screen == "ChooseAINameAndGenderView" {
      ChooseAINameAndGenderView(path: $path)
        .environmentObject(vm)
    }else if screen == "AIAge" {
      AIAgeView(path:$path)
        .environmentObject(vm)
    }else if screen == "ChoosePersonalityView" {
      ChoosePersonalityView(path: $path)
        .environmentObject(vm)
    }else if screen == "AppSubscriptionView" {
      AppSubscriptionView(isPresented: .constant(false),
                          path: $path)
      .environmentObject(vm)
    } else if screen == "ChatList" {
      ChatListView(vm: ChatListViewModel(),
                   path: $path)
      .environmentObject(vm)
    }else if screen == "ChatViewScreen" {
      ChatViewScreen(vm: .init(aiModel: vm.userAnswers.getAIModel()),
                     path: $path)
    }else if screen == "SettingsView" {
      SettingsView(path:$path)
        .environmentObject(vm)
    }
  }
  
  private func userNameView(pushedFrom:UserNamePushedFrom) -> some View {
    switch pushedFrom {
      case .landing:
        UserNameView(isFromStartNewChat: .constant(false),
                     path: $path)
        .environmentObject(vm)
      case .startNewChat:
        UserNameView(isFromStartNewChat: .constant(true),
                     path: $path)
        .environmentObject(vm)
    }
  }
}

#Preview {
  LandingScreen(path:.constant(NavigationPath()))
    .environmentObject(LandingFlowViewModel())
}

extension LandingScreen {
  private var titleHeader:some View {
    Text("Genesia AI")
      .font(.system(size: 40))
      .bold()
      .padding()
      .foregroundStyle(.white)
  }
  
  private var letsStartButton:some View {
    RoundedRectangleButton(title: "Let's Start",
                           titleColor: .darkBlue,
                           isDisabled: .constant(false))
    .scaleEffect(scale)
    .onAppear {
      startScalingAnimation()
    }
    .onTapGesture {
      path.append(UserNamePushedFrom.landing)
    }
  }
  private var infoView: some View {
    Text("The AI friend who is always there for you")
      .frame(minWidth: 0, idealWidth: 200, maxWidth: 300, minHeight: 0, idealHeight: 80, maxHeight: 80, alignment: .center)
      .foregroundStyle(.white)
      .font(.system(size: 25, weight: .semibold))
  }
  
  private var termsAndPolicyView: some View {
    VStack(spacing:0) {
      Text("By signing up, you agree to our")
        .foregroundStyle(.gray)
        .font(.caption2)
        .frame(width: 200, alignment: .center)
        .padding(.top)
      HStack(spacing: 5) {
        Button {
          showTermsOfService = true
        } label: {
          Text("Terms of Service")
            .foregroundStyle(.gray)
            .font(.caption)
            .underline()
        }
        Text("and")
          .foregroundStyle(.gray)
          .font(.caption)
        
        Button {
          showPrivacyPolicy = true
        } label: {
          Text("Privacy Policy")
            .foregroundStyle(.gray)
            .font(.caption)
            .underline()
        }
      }
    }

  }
  
  private var backgroundView: some View {
    ZStack(alignment:.center) {
      Image(imageNames[currentIndex])
        .resizable()
        .scaledToFill()
        .transition(.opacity)
      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [.darkBlue, .clear]),
            startPoint: .bottom,
            endPoint: .top
          )
        )
        .ignoresSafeArea()
    }.ignoresSafeArea()
  }
}
