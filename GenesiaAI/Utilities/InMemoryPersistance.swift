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
}
