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
        NavigationView {
            VStack {
                Divider()
                HStack {
                    Spacer()
                    Text("Score: \(viewModel.score)").padding(.trailing, trailingSpace)
                }.foregroundColor(secondaryColor)
                            
                GridView(items: viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.75)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                    .foregroundColor(self.viewModel.cardColor)
                    .padding(self.cardSpace)
                }
                .padding()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                }, label: {
                    Text("New Game")
                        .padding(ButtonConstants.textInsets)
                        .foregroundColor(.white)
                }).padding(.horizontal)
                    .background(secondaryColor)
                    .cornerRadius(ButtonConstants.cornerRadius)
                    .padding(.horizontal)
            }
            .foregroundColor(.blue)
            .navigationBarTitle(Text(viewModel.gameName))
            .navigationBarColor(viewModel.topColor)
        }
    }
    
    //MARK: - Drawing constants
    enum ButtonConstants {
        static let textInsets = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        static let cornerRadius: CGFloat = 10
    }
    
    let secondaryColor = Color(red: 0.2627, green: 0.5922, blue: 1)
    let trailingSpace: CGFloat = 22
    let cardSpace: CGFloat = 5
    let navigationBarColor = UIColor.systemPink
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: .halloween)
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
