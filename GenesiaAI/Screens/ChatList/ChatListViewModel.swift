//
//  ChatListViewModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 22/06/2024.
//

import Foundation

final class ChatListViewModel:ObservableObject {

  func getAvailableAIModels() -> [AIModel] {
    InMemoryPersistance.getAIModels()
  }
}
