//
//  AppSubscriptionView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 21/06/2024.
//

import SwiftUI

struct AppSubscriptionView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  @State private var weeklySubscriptionSelected:Bool = true
  @State private var yearlySubscriptionSelected:Bool = false
  @State private var pulsate = false
  @State private var isMuted = false
  
  var body: some View {
    NavigationStack {
      ZStack {
        Image(vm.userAnswers.selectedAvatar ?? "5thChar")
          .resizable()
        gradientView
        contentView
      }.ignoresSafeArea()
    }.navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomXButton()
        }
        ToolbarItem(placement: .topBarTrailing) {
          Image(systemName: isMuted ? "speaker.wave.2.fill" : "speaker.slash.fill")
            .scaleEffect(pulsate ? 1.4 : 1.0)
            .animation(
              pulsate ?
              Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true) :
                  .default,
              value: pulsate
            )
            .onTapGesture {
              isMuted.toggle()
              pulsate = false
            }
            .onAppear {
              pulsate = true
            }
          
        }
      }
      .onAppear {
        pulsate = true
      }
  }
}

extension AppSubscriptionView {
  private var title: some View {
    HStack {
      Text("Genesia")
        .font(.system(size: 30))
        .fontWeight(.regular)
      Text("AI")
        .font(.system(size: 30))
        .fontWeight(.light)
      Text("PRO")
        .font(.system(size: 40, weight: .semibold, design: .rounded))
    }
  }
  
  private var subscriptionFeaturesView:some View {
    VStack(alignment: .leading,spacing:15) {
      HStack {
        Image(systemName: "infinity")
          .font(.system(size: 25))
        Text("Unlimited Messages")
          .font(.system(size: 20))
      }
      HStack {
        Image(systemName: "lock.open")
          .font(.system(size: 25))
        Text(" Unlock Chat Photos")
          .font(.system(size: 20))
      }
      HStack {
        Image(systemName: "moon.stars")
          .font(.system(size: 25))
        Text("  Romantic Partner")
          .font(.system(size: 20))
      }
      HStack {
        Image(systemName: "video.fill")
          .font(.system(size: 25))
        Text(" Special Video Calls")
          .font(.system(size: 20))
      }
    }
  }
  
  private var weeklySubscriptionView:some View {
    VStack(alignment:.leading) {
      Text("3 days FREE TRIAL, Auto Renewal")
        .font(.footnote)
        .foregroundStyle(.gray)
      Text("EGP149.99/week, cancel anytime")
    }.padding()
      .frame(width:350)
      .background(
        .thinMaterial
      )
      .overlay {
        RoundedRectangle(cornerRadius: 30)
          .stroke(weeklySubscriptionSelected ? Color.white : Color.white.opacity(0.3),lineWidth: 2)
          .animation(.snappy, value: weeklySubscriptionSelected)
      }
      .overlay {
        Color.white.opacity(weeklySubscriptionSelected ? 0.3 : 0)
          .animation(.snappy, value: weeklySubscriptionSelected)
      }
      .clipShape(RoundedRectangle(cornerRadius: 30))
      .onTapGesture {
          yearlySubscriptionSelected = false
          weeklySubscriptionSelected = true
      }
  }
  
  private var yearlySubscriptionView:some View {
    ZStack {
      VStack(alignment:.leading) {
        Text("Auto Renewal")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("EGP1199.99/year, cancel anytime")
      }.padding()
        .frame(width:350)
        .background(
          .thinMaterial
        )
        .overlay {
          RoundedRectangle(cornerRadius: 30)
            .stroke(yearlySubscriptionSelected ? Color.white : Color.white.opacity(0.3),lineWidth:2)
            .animation(.snappy, value: yearlySubscriptionSelected)
        }
        .overlay {
          Color.white.opacity(yearlySubscriptionSelected ? 0.3 : 0)
            .animation(.snappy, value: yearlySubscriptionSelected)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onTapGesture {
          yearlySubscriptionSelected = true
          weeklySubscriptionSelected = false
        }
      Text("Save 90%")
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(.black)
        .padding(5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .offset(x: 120, y: -20)
    }
  }
  
  private var gradientView:some View {
    VStack {
      Spacer()
      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [.darkBlue, .clear]),
            startPoint: .bottom,
            endPoint: .top
          )
        )
        .ignoresSafeArea()
        .frame(height:400)
    }
  }
  
  private var termsAndPrivacyView: some View {
    HStack(spacing:5){
      Text("Privacy")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
      Text("&")
        .font(.footnote)
        .foregroundStyle(.gray)
      Text("Terms")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
      if !yearlySubscriptionSelected {
        ZStack {
          Image(systemName: "shield.fill")
            .foregroundStyle(.green)
            .font(.system(size: 20))
            .bold()
          Image(systemName: "checkmark")
            .foregroundStyle(.white)
            .font(.system(size: 10))
            .bold()
        }
      }
      Text(yearlySubscriptionSelected ? "" : "No payment now")
        .font(.subheadline)
        .fontWeight(.semibold)
      Text("Restore")
        .font(.caption)
        .foregroundStyle(.gray)
    }.frame(height:15)
  }
  
  private var contentView: some View {
    VStack(alignment:.center) {
      title
        .padding(.top,50)
      Spacer()
      VStack(spacing:15) {
        subscriptionFeaturesView
        weeklySubscriptionView
        yearlySubscriptionView
        RoundedRectangleButton(title: weeklySubscriptionSelected ? "Start my 3-day free trial" : "Start Plan",
                               isDisabled: .constant(false))
        .animation(.spring, value: weeklySubscriptionSelected)
        termsAndPrivacyView
      }.padding(.bottom,20)
    }
  }
}

#Preview {
    AppSubscriptionView()
    .environmentObject(LandingFlowViewModel())
}

