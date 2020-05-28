//
//  ContentView.swift
//  Memorize
//
//  Created by Holyberry on 28.05.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI
import GameplayKit

struct ContentView: View {
    var cards: [[CardView.Card]] = makeCards()

    var body: some View {
        HStack {
            ForEach(0..<cards.count) { column in
                VStack {
                    ForEach(0..<self.cards[column].count) { row in
                        CardView(card: self.cards[column][row])
                    }
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    struct Card {
        var isFaceUp: Bool
        var emoji: String
    }
    
    var card: Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 10).fill().foregroundColor(.white)
                Text(card.emoji)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//TODO: do in the right place
func makeCards() -> [[CardView.Card]] {
    let emoji = ["👻", "💀", "☠️", "👽", "👾", "👹", "😈", "🎃", "💩", "🤖", "🦇", "🐙"]
    
    let meshedCards = (emoji + emoji)
        .shuffled(using: GKRandomSource.sharedRandom())
        .map { CardView.Card(isFaceUp: true, emoji: $0) }
    
    let step = 6
    assert(emoji.count % step == 0)
    
    return stride(from: 0,
                  to: meshedCards.count,
                  by: step)
        .map { Array(meshedCards[$0..<$0+step]) }
}
