  //
  //  ChatListView.swift
  //  GenesiaAI
  //
  //  Created by Ahmed Bahgat on 22/06/2024.
  //

import SwiftUI

struct ChatListView: View {
  @StateObject var vm:ChatListViewModel
  @EnvironmentObject var landingFlowVM:LandingFlowViewModel
  
  @State private var presentProView:Bool = false
  @Binding var path:NavigationPath
  
  var body: some View {
      ZStack {
        Color.darkBlue
          .ignoresSafeArea()
        VStack{
          headerView
          separatorLineView
          chatListView
          RoundedRectangleButton(title: "Start New Chat", titleColor: .darkBlue,
                                 isDisabled: .constant(false))
          .onTapGesture {
            path.append(UserNamePushedFrom.startNewChat)

          }
        }
      }.navigationBarBackButtonHidden()
  }
  
  func deleteRow(modelID:UUID) {
    vm.deleteAIModel(modelID: modelID)
  }
  func pinModel(modelID:UUID,pinned:Bool) {
    vm.pinModel(modelID: modelID,pinned: pinned)
  }
}

#Preview {
  let vm = ChatListViewModel()
  return ChatListView(vm: .init(),path: .constant(NavigationPath()))
    .environmentObject(LandingFlowViewModel())
}

extension ChatListView {
  private var separatorLineView:some View {
    Rectangle()
      .frame(height: 2)
      .foregroundColor(Color.white.opacity(0.1))
      .padding(.vertical, 10)
  }
  private var headerView:some View {
    HStack {
      Text("Genesia AI")
        .font(.largeTitle)
        .foregroundStyle(.white)
      Spacer()
      ZStack {
        HStack {
          Image(systemName: "star.fill")
            .foregroundStyle(.white)
          Text("PRO")
            .foregroundStyle(.white)
            .bold()
        }.shadow(color: .white, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
          .padding(10)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.white)
          )
          .onTapGesture {
            presentProView = true
          }
          .fullScreenCover(isPresented: $presentProView,onDismiss: {
            presentProView = false
          })  {
            AppSubscriptionView(isPresented: $presentProView,
                                path: $path)
              .environmentObject(landingFlowVM)
          }
      }.padding(.horizontal,10)
      Image(systemName: "gearshape.fill")
        .foregroundStyle(.gray)
        .font(.system(size: 20))
        .onTapGesture {
          path.append("SettingsView")
        }
    }.padding(.horizontal,30)
  }
  
  private var chatListView:some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.flexible())]) {
        ForEach(vm.aiModels) { model in
          ChatView(model: model)
          .onTapGesture {
            path.append(model)
          }.contextMenu {
            Button(action: {
              pinModel(modelID: model.id,pinned: !model.isChatPinned)
            }) {
              Text(model.isChatPinned ? "Unpin" : "Pin")
              Image(systemName: model.isChatPinned ? "pin.slash.fill" :"pin")
            }
            Button(role:.destructive,action: {
              deleteRow(modelID: model.id)
            }) {
              Text("Delete")
              Image(systemName: "trash")
            }
          }
        }
      }
    }.scrollIndicators(.hidden)
  }
}
