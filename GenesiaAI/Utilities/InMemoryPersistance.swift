//
//  InMemoryPersistance.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 23/06/2024.
//

import Foundation
final class InMemoryPersistance {
  
  static private var aiModels:[AIModel] = []
  
  static func saveModel(model: AIModel) {
    aiModels.append(model)
  }
  
  static func getAIModels() -> [AIModel] {
    return aiModels
  }
  
  static func clearData() {
    aiModels = []
  }
  
  static func deleteAIModel(modelID:UUID) {
    aiModels.removeAll {$0.id == modelID}
  }
  
  static func pinModel(modelID:UUID,pinned:Bool) {
    aiModels = aiModels.map{ model in
      let newModel = model
      newModel.isChatPinned = false
      return newModel
    }
    aiModels.filter {$0.id == modelID}.first?.isChatPinned = pinned
    guard let isChatPinnedItem = (aiModels.first { $0.isChatPinned }) else { return }
    deleteAIModel(modelID: isChatPinnedItem.id)
    aiModels.insert(isChatPinnedItem, at: 0)
  }
}
