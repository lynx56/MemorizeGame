//
//  MemoryGame.swift
//  Memorize
//
//  Created by Holyberry on 01.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation
import GameplayKit

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    
    init(countPairs: Int, createContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<countPairs {
            let content = createContentFactory(index)
            cards.append(.init(content: content, id: index*2))
            cards.append(.init(content: content, id: index*2 + 1))
        }
    }
    
    private var indexOfTheOneAndOnlyOneFaceUpCard: Int? {
        get {
            let faceUpCards = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpCards.count == 1 ? faceUpCards.first! : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        guard let choosenCardIndex = cards.firstIndex(matching: card) else { return }
        guard !cards[choosenCardIndex].isFaceUp, !cards[choosenCardIndex].isMatched else { return }
        
        guard let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard else { indexOfTheOneAndOnlyOneFaceUpCard = choosenCardIndex; return }
        
        if cards[choosenCardIndex].content == cards[potentialMatchIndex].content {
            cards[choosenCardIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
        }
        
        cards[choosenCardIndex].isFaceUp = true
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
