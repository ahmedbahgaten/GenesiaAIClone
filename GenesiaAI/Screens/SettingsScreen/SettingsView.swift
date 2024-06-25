  //
  //  SettingsView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 23/06/2024.
  //
import SwiftUI

struct SettingsView:View {
  @State var isVideoOn:Bool = false
  @State var showCustomPopUp:Bool = false
  @EnvironmentObject var vm:LandingFlowViewModel
  @Binding var path:NavigationPath
  var body: some View {
      ZStack {
        Color.darkBlue
        ScrollView {
          VStack(spacing:25) {
            SettingItemView(title: "Remaining Call Time") {
              Text("00:00")
                .foregroundStyle(.white)
            }
            Toggle(isOn: $isVideoOn) {
              Text("Background Video On")
                .foregroundStyle(.white)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .lineLimit(1)
            }.padding(.horizontal)
              .frame(height: 60)
              .background(Color.gray.opacity(0.2))
              .clipShape(RoundedRectangle(cornerRadius: 20))
            SettingItemView(title: "Share Genesia") {
              Image(systemName:"square.and.arrow.up.fill")
                .foregroundStyle(.white)
            }
            VStack(spacing:20) {
              HStack {
                Text("About Codeway")
                Spacer()
              }
              Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray.opacity(0.08))
              HStack {
                Text("Like us , Rate us 🤍")
                Spacer()
              }
              Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray.opacity(0.08))
              HStack {
                Text("FAQ & Support")
                Spacer()
                Image(systemName: "chevron.right")
                  .foregroundStyle(.white)
              }
              Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray.opacity(0.08))
              HStack {
                Text("Email Support")
                Spacer()
              }
            }.font(.system(size: 18))
              .fontWeight(.semibold)
              .padding()
              .background(Color.gray.opacity(0.2))
              .clipShape(RoundedRectangle(cornerRadius: 20))
              .foregroundStyle(.white)
            
            VStack(spacing:20) {
              HStack {
                Text("Restore Purchase")
                Spacer()
              }
              Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray.opacity(0.08))
              HStack {
                Text("Privacy Policy")
                Spacer()
              }
              Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray.opacity(0.08))
              HStack {
                Text("Terms of Service")
                Spacer()
              }
            }.font(.system(size: 18))
              .fontWeight(.semibold)
              .padding()
              .background(Color.gray.opacity(0.2))
              .clipShape(RoundedRectangle(cornerRadius: 20))
              .foregroundStyle(.white)
            SettingItemView(title: "Reset Data", titleColor: .red) {}
              .onTapGesture {
                withAnimation {
                  showCustomPopUp = true
                }
              }
          }.padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .padding(.vertical,100)
        if showCustomPopUp {
          BackgroundBlur(style: .dark)
            .transition(.opacity)
            .zIndex(1)
            .onTapGesture {
              withAnimation {
                showCustomPopUp = false
              }
            }
          popupView
            .transition(.opacity)
            .frame(width: 300, height: 400)
            .zIndex(2)
          
        }
      }.ignoresSafeArea()
    .navigationTitle("Settings")
    .navigationBarBackButtonHidden()
    .toolbar{
      ToolbarItem(placement: .topBarLeading) {
        CustomBackButton()
      }
    }
    }
}
#Preview {
  SettingsView(path:.constant(NavigationPath()))
    .environmentObject(LandingFlowViewModel())
}
extension SettingsView {
  
  private var popupView:some View {
    CustomPopUpView(title: "Are you sure?",
                    message: "All of your data and AI Characters will be erased permanently.",
                    primaryButton:RoundedRectangleButton(title: "Reset Data", titleColor: .red, isDisabled: .constant(false)).onTapGesture {
      vm.clear()
      path.removeLast(path.count)
    }, secondaryButton:Button(action: {
      withAnimation {
        showCustomPopUp = false
      }
    }, label: {
      Text("Cancel")
        .foregroundStyle(.white)
    }).padding()
    ).transition(.opacity)
      .frame(width: 300, height: 400)
  }
}

