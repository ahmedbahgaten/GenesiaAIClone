//
//  TagView.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 20/06/2024.
//

import SwiftUI


struct TagView: View {
  
  @State var tags: [InterestsModel]
  @State private var totalHeight = CGFloat.zero  
  var maxSelection = 5
  @Binding var noSelectedItems:Bool
  @Binding var selectedInterests:[String]
  
  
  var body: some View {
    ZStack {
      Color.darkBlue
      VStack {
        GeometryReader { geometry in
          self.generateContent(in: geometry)
        }
      }
      .frame(height: totalHeight)
    }.ignoresSafeArea()
      .onAppear {
        selectedInterests = tags.filter {$0.isSelected}.map {$0.title}
      }
  }
  
  private func generateContent(in g: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    let selectedCount = tags.filter { $0.isSelected }.count

    return ZStack(alignment: .topLeading) {
      ForEach(0..<tags.count,id:\.self) { index in
        item(for: tags[index].title, isSelected: tags[index].isSelected)
          .padding([.horizontal, .vertical], 4)
          .alignmentGuide(.leading, computeValue: { d in
            if (abs(width - d.width) > g.size.width) {
              width = 0
              height -= d.height
            }
            let result = width
            if tags[index].title == self.tags.last!.title {
              width = 0 //last item
            } else {
              width -= d.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: {d in
            let result = height
            if tags[index].title == self.tags.last!.title {
              height = 0 // last item
            }
            return result
          })
          .onTapGesture {
            if selectedCount < maxSelection || tags[index].isSelected {
              tags[index].isSelected.toggle()
              let selectedItems = tags.filter { $0.isSelected }
              withAnimation {
                noSelectedItems = selectedItems.count == 0
              }
              selectedInterests = selectedItems.map {$0.title}
              guard selectedItems.count == maxSelection else { return }
              HapticFeedbackManager.shared.triggerImpactFeedback(style: .medium)
            }
          }
      }
    }.background(viewHeightReader($totalHeight))
  }
  
  private func item(for text: String, isSelected: Bool) -> some View {
    Text(text)
      .foregroundColor(.white)
      .padding()
      .lineLimit(1)
      .frame(height: 40)
      .cornerRadius(18)
      .font(.system(size: 18))
      .background(
        isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.1)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(isSelected ? Color.white : Color.gray.opacity(0.3))
      }
      .opacity(
        isSelected ? 1 : selectedInterests.count == maxSelection ? 0.3 : 1
      )
  }
  
  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
      let rect = geometry.frame(in: .local)
      DispatchQueue.main.async {
        binding.wrappedValue = rect.size.height
      }
      return .clear
    }
  }
}

