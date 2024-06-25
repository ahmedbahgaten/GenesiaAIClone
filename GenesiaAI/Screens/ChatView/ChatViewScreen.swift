  //
  //  ChatView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 24/06/2024.
  //

import SwiftUI

struct ChatViewScreen: View {
  @State private var userInputMessage:String = ""
  @FocusState private var isFocused: Bool
  @State private var isMessageEmpty = true
  @StateObject var vm:ChatViewViewModel
  @Binding var path:NavigationPath
  @State var showProScreen:Bool = false
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.darkBlue
        .ignoresSafeArea()
        .onTapGesture {
          isFocused = false
        }
      VStack(spacing: 0) {
        headerView
        Spacer()
        bottomView
          .padding()
          .zIndex(1)
      }
    }.onAppear {
      isFocused.toggle()
    }
    .fullScreenCover(isPresented: $showProScreen,onDismiss: {
      showProScreen = false
    })  {
      AppSubscriptionView(isPresented: $showProScreen,
                          path: .constant(NavigationPath()))
      .environmentObject(LandingFlowViewModel())
    }
    .navigationBarBackButtonHidden()
  }
}

extension ChatViewScreen {
  private var headerView:some View {
    HStack {
      CustomBackButton()
      Spacer()
      Image(vm.aiModel.selectedAvatar ?? "")
        .resizable()
        .frame(width: 50,height: 50)
        .clipShape(Circle())
      VStack(alignment:.leading) {
        HStack{
          Text(vm.aiModel.aiName)
          Text("·")
            .font(.system(size: 30))
            .bold()
            .foregroundStyle(.green)
        }
        Text("Tap for more info")
          .font(.footnote)
          .foregroundStyle(.gray)
      }.foregroundStyle(.white)
      Spacer()
      HStack {
        HStack {
          Text("PRO")
            .foregroundStyle(.white)
            .bold()
        }.shadow(color: .white, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
          .frame(width: 50)
          .padding(10)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.white)
          )
          .onTapGesture {
            showProScreen = true
          }
        Image(systemName: "video.fill")
          .foregroundStyle(.gray)
          .font(.system(size: 22))
          .padding(.leading,10)
      }
    }
    .padding()
  }
  
  private var bottomView:some View {
    HStack {
      TextField("", text: $userInputMessage, prompt: Text("Type your message...").foregroundStyle(.gray),axis: .vertical)
        .foregroundStyle(.white)
        .focused($isFocused)
        .padding()
        .lineLimit(7)
        .autocorrectionDisabled()
        .background(RoundedRectangle(cornerRadius: 30)
          .foregroundStyle(.white.opacity(0.2)))
        .onChange(of: userInputMessage) { oldValue, newValue in
          withAnimation {
            isMessageEmpty = newValue.isEmpty
          }
        }
      Image(systemName:"arrowshape.turn.up.right.circle.fill")
        .font(.system(size: 25))
        .foregroundStyle(.darkBlue)
        .padding()
        .background(RoundedRectangle(cornerRadius: 30)
          .foregroundStyle(.white.opacity(isMessageEmpty ? 0.3 : 1)))
    }
  }
}

#Preview {
  let aiModel = AIModel()
  aiModel.selectedAvatar = "5thChar"
  aiModel.aiName = "Selia"
  return ChatViewScreen(vm: ChatViewViewModel(aiModel: aiModel),path: .constant(NavigationPath()))
}
