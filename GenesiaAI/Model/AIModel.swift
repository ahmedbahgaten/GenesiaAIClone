//
//  AIModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 25/06/2024.
//

import Foundation
final class AIModel:Identifiable,Hashable {
  static func == (lhs: AIModel, rhs: AIModel) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  let id:UUID = UUID()
  var aiName:String = ""
  var aiGender:String = "Female"
  var aiAge:Int = 18
  var selectedAvatar:String?
  var selectedPersonality:String = AIPersonalityModel.getPersonalities().first ?? ""
}
