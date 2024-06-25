//
//  UserModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import Foundation

final class UserAnswers:ObservableObject {
  var username:String = ""
  var userPronouns:String = "He/Him"
  var dateOfBirth:Date = .now
  var interests:[String] = []
  var selectedAvatar:String? 
  var aiName:String = ""
  var aiGender:String = "Female"
  var aiAge:Int = 18
  @Published var selectedPersonality:String = AIPersonalityModel.getPersonalities().first ?? ""
  
  func getAIModel() -> AIModel {
    let model = AIModel()
    model.aiAge = aiAge
    model.aiName = aiName
    model.selectedAvatar = selectedAvatar
    model.aiGender = aiGender
    model.selectedPersonality = selectedPersonality
    return model
  }
}
