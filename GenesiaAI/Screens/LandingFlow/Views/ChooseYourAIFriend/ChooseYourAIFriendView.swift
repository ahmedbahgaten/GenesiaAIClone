  //
  //  ChooseYourAIFriendView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 20/06/2024.
  //

import SwiftUI

struct ChooseYourAIFriendView: View {
  @EnvironmentObject var vm:LandingFlowViewModel
  @State private var selectedAvatar: String = ""

  
  var body: some View {
    NavigationStack {
      ZStack {
        Image(selectedAvatar)
          .resizable()
          .ignoresSafeArea()
        chooseYourAIFriendView
        gradientView
          .ignoresSafeArea()
        bottomView
      }
    }.onAppear {
      if selectedAvatar.isEmpty {
        selectedAvatar = vm.avatars.first ?? ""
      }
    }
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton()
        }
      }
  }
}

#Preview {
  ChooseYourAIFriendView()
    .environmentObject(LandingFlowViewModel())
}

extension ChooseYourAIFriendView {
  private var horizontalListView: some View {
    GeometryReader { geometry in
      let itemSize:CGFloat = 60
      let horizontalPadding = (geometry.size.width - itemSize) / 2
      let spacing:CGFloat = 20
      VStack {
        Spacer()
        ScrollViewReader { proxy in
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
              ForEach(vm.avatars, id: \.self) { avatar in
                Image(avatar)
                  .resizable()
                  .scaledToFill()
                  .frame(width: itemSize, height: itemSize)
                  .clipShape(Circle())
                  .padding(6)
                  .overlay(Circle().stroke(selectedAvatar == avatar ? Color.white : Color.clear, lineWidth: 2))
                  .onTapGesture {
                    withAnimation(.easeInOut) {
                      selectedAvatar = avatar
                      proxy.scrollTo(avatar,anchor: .center)
                    }
                  }
              }
            }.padding(.horizontal,horizontalPadding)
              .frame(height:itemSize + 15)
          }
        }.padding(.bottom, 20)
      }
    }
  }
  
  private var gradientView:some View {
    VStack {
      Spacer()
      Rectangle()
        .fill(Color.clear)
        .frame(height:250)
        .overlay {
          LinearGradient(
            gradient: Gradient(colors: [.darkBlue, .clear]),
            startPoint: .center,
            endPoint: .top)
        }
        .allowsHitTesting(false)
    }
  }
  
  private var bottomView: some View {
    VStack {
      Spacer()
      horizontalListView
      NavigationLink {
        vm.userAnswers.selectedAvatar = selectedAvatar
        return ChooseAINameAndGenderView()
          .environmentObject(vm)
      } label: {
        RoundedRectangleButton(title: "Continue", isDisabled: .constant(false))
      }
    }.padding(.bottom,40)
  }
  
  private var chooseYourAIFriendView: some View {
    VStack {
      Text("Choose your AI Friend")
        .font(.system(size: 22))
        .fontWeight(.semibold)
      Spacer()
    }
  }
}
