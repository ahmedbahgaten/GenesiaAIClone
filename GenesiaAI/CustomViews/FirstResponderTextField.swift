//
//  FirstResponderTextField.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import Foundation
import SwiftUI

struct FirstResponderTextField: UIViewRepresentable {
  @Binding var text: String
  var placeholder: String
  
  class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
      _text = text
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
      text = textField.text ?? ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
  }
  
  func makeUIView(context: Context) -> UITextField {
    let textField = UITextField()
    textField.delegate = context.coordinator
    textField.placeholder = placeholder
    textField.returnKeyType = .done
    textField.textAlignment = .center
    textField.becomeFirstResponder() // Make the text field the first responder when it appears
    return textField
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(text: $text)
  }
  
  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
  }
}
