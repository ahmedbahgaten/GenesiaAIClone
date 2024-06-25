//
//  LandingFlowViewModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import Foundation

final class LandingFlowViewModel:ObservableObject {
  var userAnswers = UserAnswers()
  var interests = InterestsModel.getTags()
  let avatars = ["1stChar", "2ndChar", "3rdChar", "4thChar",]
  var aiPersonalities = AIPersonalityModel.getPersonalities()
  
  func setUserInterests(interests:[String]) {
    userAnswers.interests = interests
  }
  
  func saveAIModel() {
    let aiModel = AIModel()
    aiModel.aiAge = userAnswers.aiAge
    aiModel.aiName = userAnswers.aiName
    aiModel.aiGender = userAnswers.aiGender
    aiModel.selectedAvatar = userAnswers.selectedAvatar
    aiModel.selectedPersonality = userAnswers.selectedPersonality
    InMemoryPersistance.saveModel(model: aiModel)
  }
  
  func clear() {
      self.userAnswers = UserAnswers()
      self.interests = InterestsModel.getTags()
      InMemoryPersistance.clearData()
  }
}
