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
    private(set) var cards: [Card]
    
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
            return cards.indices.filter { cards[$0].isFaceUp }.single
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    private(set) var totalScore = 0
    private var penalty = 1
    private var reward = 2
    
    mutating func choose(card: Card) {
        guard let choosenCardIndex = cards.firstIndex(matching: card) else { return }
        guard !cards[choosenCardIndex].isFaceUp, !cards[choosenCardIndex].isMatched else { return }
        
        guard let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard else { indexOfTheOneAndOnlyOneFaceUpCard = choosenCardIndex; return }
        
        if cards[choosenCardIndex].content == cards[potentialMatchIndex].content {
            cards[choosenCardIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
            totalScore += reward
        } else {
            if card.alreadySeen {
                totalScore -= penalty
            }
        }
        cards[choosenCardIndex].isFaceUp = true
    }
    
    mutating func shuffleCards() {
        cards = cards.shuffled(using: GKRandomSource.sharedRandom())
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            willSet {
                alreadySeen = alreadySeen == true || isFaceUp == true && newValue == false
            }
            didSet {
                isFaceUp ? startUsingBonusTime() : stopUsingBonusTime()
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        var alreadySeen: Bool = false
        
        //MARK: - Time Calculations
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        //how long this card has ever been face up
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        mutating private func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        mutating private func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
