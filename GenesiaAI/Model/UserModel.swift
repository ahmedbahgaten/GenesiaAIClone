//
//  UserModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 19/06/2024.
//

import Foundation

class UserAnswers:ObservableObject {
  var username:String = ""
  var userPronouns:String = "He/Him"
  var dateOfBirth:Date = .now
  var interests:[String] = []
  var selectedAvatar:String? 
  var aiName:String = ""
  var aiGender:String = "Female"
  var aiAge:Int = 18
  @Published var selectedPersonality:String = AIPersonalityModel.getPersonalities().first ?? ""
}
