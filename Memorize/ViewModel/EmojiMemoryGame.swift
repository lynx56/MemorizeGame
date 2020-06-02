//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Holyberry on 01.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emoji = ["👻", "💀", "☠️", "👽", "👾", "👹", "😈", "🎃", "💩", "🤖", "🦇", "🐙"]
        var game = MemoryGame(countPairs: emoji.count) { return emoji[$0] }
        game.shuffleCards()
        return game
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
}
