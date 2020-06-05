//
//  CardView.swift
//  Memorize
//
//  Created by Holyberry on 05.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

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
