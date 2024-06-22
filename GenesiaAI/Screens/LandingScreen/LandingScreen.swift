  //
  //  ContentView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 19/06/2024.
  //

import SwiftUI
struct LandingScreen: View {
  let imageNames = ["1stChar",
                    "2ndChar",
                    "3rdChar",
                    "4thChar"]
  var timer:Timer?
  @State private var currentIndex = 0
  @State private var showPrivacyPolicy = false
  @State private var showTermsOfService = false
  
  mutating func setTimer(timer:Timer) {
    self.timer = timer
  }
  mutating func cancelTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        titleHeader
        Spacer()
        infoView
        letsStartButton
        termsAndPolicyView
      }
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
}

#Preview {
  LandingScreen()
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
    NavigationLink {
      Prefs.isLandingScreenByPassed = true
      return UserNameView()
    } label: {
      RoundedRectangleButton(title: "Let's Start",
                             isDisabled: .constant(false))
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
      .onAppear {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
          withAnimation {
            currentIndex = (currentIndex + 1) % imageNames.count
          }
        }
      }
  }
}
