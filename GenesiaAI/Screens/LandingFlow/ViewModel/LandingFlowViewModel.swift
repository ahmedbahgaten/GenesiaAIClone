//
//  LandingFlowViewModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import Foundation

class LandingFlowViewModel:ObservableObject {
  @Published var userAnswers = UserAnswers()
  let interests = InterestsModel.getTags()
  let avatars = ["5thChar", "6thChar", "7thChar", "8thChar",]
  var aiPersonalities = AIPersonalityModel.getPersonalities()
  
  func setUserInterests() {
    userAnswers.interests = interests.filter {$0.isSelected}.map { $0.title }
  }
}
