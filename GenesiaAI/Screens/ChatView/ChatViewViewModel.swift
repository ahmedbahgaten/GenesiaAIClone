//
//  ChatViewViewModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 24/06/2024.
//

import Foundation

class ChatViewViewModel:ObservableObject{
  @Published var aiModel:AIModel
  
  init(aiModel: AIModel) {
    self.aiModel = aiModel
  }
  
}
