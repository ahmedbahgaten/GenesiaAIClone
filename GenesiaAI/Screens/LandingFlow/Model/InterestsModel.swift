//
//  InterestsModel.swift
//  GenesiaAI
//
//  Created by Ahmed Bahgat on 20/06/2024.
//

import Foundation

class InterestsModel {
  var title:String = ""
  var isSelected:Bool = false
  
  init(title: String, isSelected: Bool = false ) {
    self.title = title
    self.isSelected = isSelected
  }
  
  static func getTags() -> [InterestsModel] {
    [InterestsModel(title: "🎨 Art and Creativity"),
            .init(title: "📚 Literature")
            ,.init(title: "🎥 Movies and TV Shows"),
            .init(title: "💃🏻 Dancing")
            ,.init(title: "🐶 Pets and Animals"),
            .init(title: "🌱 Gardening"),
            .init(title: "🌍 Volunteering"),
            .init(title: "💻 Technology"),
            .init(title: "👗 Fashion"),
            .init(title: "✈️ Travel"),
            .init(title: "🎵 Music"),
            .init(title: "⚽️ Sports"),
            .init(title: "🎮 Gaming"),
            .init(title: "💼 Career"),
            .init(title: "🍳 Cooking"),
            .init(title: "💪 Fitness"),
            .init(title: "☕️ Coffee"),
            .init(title: "💭 Philosophy/Existential questions"),
            .init(title: "🎭 Theater and Performing Arts"),
            .init(title: "🌍Environmental Sustainability")]
  }
}
