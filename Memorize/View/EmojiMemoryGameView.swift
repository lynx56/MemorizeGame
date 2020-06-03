//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Holyberry on 28.05.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            GridView(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatingBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatingBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeLimit)) {
            animatingBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(.zero - 90),
                            endAngle: .degrees(-animatingBonusRemaining*360 - 90),
                            clockwise: true)
                            .onAppear() {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: .degrees(.zero - 90),
                            endAngle: .degrees(-card.bonusRemaining*360 - 90),
                            clockwise: true)
                    }
                }.opacity(0.4)
                 .padding(5)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    
    //MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.height, size.width) * 0.7
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
