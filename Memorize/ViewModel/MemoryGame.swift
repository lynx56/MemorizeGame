//
//  MemoryGame.swift
//  Memorize
//
//  Created by Holyberry on 01.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation
import GameplayKit

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    init(countPairs: Int, createContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<countPairs {
            let content = createContentFactory(index)
            cards.append(.init(content: content, id: index*2))
            cards.append(.init(content: content, id: index*2 + 1))
        }
    }
    
    mutating func choose(card: Card) {
        guard let choosenCardIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        cards[choosenCardIndex].isFaceUp = !cards[choosenCardIndex].isFaceUp
    }
    
    mutating func shuffleCards() {
        cards = cards.shuffled(using: GKRandomSource.sharedRandom())
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
