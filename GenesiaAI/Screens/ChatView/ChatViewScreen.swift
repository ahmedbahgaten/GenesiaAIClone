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
  @State var showSetRelationShipView:Bool = false
  
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
      }
      
      if showSetRelationShipView {
        relationShipView
          .transition(.move(edge: .bottom))
          .transition(.opacity)
          .zIndex(1)
      }
      
    }.fullScreenCover(isPresented: $showProScreen,onDismiss: {
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
  
  private var relationShipView: some View {
    ZStack {
      BackgroundBlur(style: .dark)
        .ignoresSafeArea()
        .onTapGesture {
          withAnimation {
            showSetRelationShipView = false
          }
        }
      VStack {
        Spacer()
        RoundedTopCorners(radius: 30)
          .fill(Color.darkBlue)
          .frame(height:450)
          .overlay {
            VStack {
              CustomXButton()
                .offset(x:-150)
                .onTapGesture {
                  withAnimation {
                    showSetRelationShipView = false
                  }
                }
              ZStack {
                Circle()
                  .fill(Color.white)
                  .frame(width: 105, height: 105) // Adjust the size to create the desired border thickness
                
                Image(vm.aiModel.selectedAvatar ?? "")
                  .resizable()
                  .scaledToFill()
                  .frame(width: 100, height: 100)
                  .clipShape(Circle())
              }
              Text("Set Your Relatioship with\n \(vm.aiModel.aiName)")
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
              Text("Friends")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .frame(width: 300, height: 60, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 30)
                  .stroke(Color.white))
                .overlay {
                  RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.4))
                }
                .onTapGesture {
                  withAnimation {
                    showSetRelationShipView = false
                  }
                }
              RoundedRectangle(cornerRadius: 30)
                .frame(width:300,height:60)
                .foregroundStyle(.white.opacity(0.1))
                .padding(5)
                .overlay{
                  HStack {
                    Image(systemName: "lock.fill")
                    Text("Romantic Partners")
                      .font(.system(size: 20))
                      .fontWeight(.semibold)
                  }.foregroundStyle(.white)
                }
                .onTapGesture {
                  showProScreen = true
                }
            }
          }
      }.ignoresSafeArea()
    }
  }
}

#Preview {
  let aiModel = AIModel()
  aiModel.selectedAvatar = "5thChar"
  aiModel.aiName = "Selia"
  return ChatViewScreen(vm: ChatViewViewModel(aiModel: aiModel),path: .constant(NavigationPath()),showSetRelationShipView: true)
}

struct RoundedTopCorners: Shape {
  var radius: CGFloat = .infinity
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
    path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false)
    path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
    path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                radius: radius,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false)
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    return path
  }
}
