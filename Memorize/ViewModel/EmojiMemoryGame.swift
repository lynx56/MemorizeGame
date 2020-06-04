//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Holyberry on 01.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String>
    @Published private(set) var gameName: String
    @Published private(set) var cardColor: Color
    
    static private func createMemoryGame(emoji: [String]) -> MemoryGame<String> {
        let emoji = emoji
        var game = MemoryGame(countPairs: emoji.count) { return emoji[$0] }
        game.shuffleCards()
        return game
    }
    
    init(theme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(emoji: theme.emoji)
        gameName = theme.rawValue
        cardColor = theme.color
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var score: Int {
        return model.totalScore
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        let randomTheme = Theme.allCases.randomElement() ?? .halloween
        model = EmojiMemoryGame.createMemoryGame(emoji: randomTheme.emoji)
        gameName = randomTheme.rawValue
        cardColor = randomTheme.color
    }
}

extension Theme {
    var color: Color {
        switch self {
        case .halloween: return .orange
        case .sport: return .blue
        case .animals: return .green
        case .faces: return .yellow
        case .transport: return .gray
        case .food: return .pink
        }
    }
}

