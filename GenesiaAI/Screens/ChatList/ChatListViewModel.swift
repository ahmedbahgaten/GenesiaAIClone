//
//  ChatListViewModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 22/06/2024.
//

import Foundation

final class ChatListViewModel:ObservableObject {
  @Published var aiModels:[AIModel] = []
  
  init() {
    aiModels = InMemoryPersistance.getAIModels()
  }
  
  func deleteAIModel(modelID:UUID) {
    InMemoryPersistance.deleteAIModel(modelID: modelID)
    aiModels = InMemoryPersistance.getAIModels()
  }
  
  func pinModel(modelID:UUID,pinned:Bool) {
    InMemoryPersistance.pinModel(modelID: modelID, pinned: pinned)
    aiModels = InMemoryPersistance.getAIModels()
  }
}
