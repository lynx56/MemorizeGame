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
    @Published private(set) var topColor: UIColor
    
    static private func createMemoryGame(emoji: [String]) -> MemoryGame<String> {
        let emoji = emoji
        var game = MemoryGame(countPairs: emoji.count) { return emoji[$0] }
        game.shuffleCards()
        return game
    }
    
    init(theme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(emoji: theme.emoji)
        gameName = theme.name
        cardColor = theme.color
        topColor = theme.uiColor.darker(0.15)
        print(theme.getJson())
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
        let themes = [Theme.halloween, Theme.animals, Theme.faces, Theme.food, Theme.sport, Theme.transport, Theme.tiktok]
        let randomTheme = themes.randomElement() ?? .halloween
        model = EmojiMemoryGame.createMemoryGame(emoji: randomTheme.emoji)
        gameName = randomTheme.name
        cardColor = randomTheme.color
        topColor = randomTheme.uiColor.darker(0.15)
        print(randomTheme.getJson())
    }
}




extension Theme: Codable {
    
    init?(json: String, encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        guard let theme = try? JSONDecoder().decode(Theme.self, from: data) else { return nil }
        self = theme
    }
    
    func getJson(encoding: String.Encoding = .utf8) -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    enum CodingKeys: String, CodingKey {
        case theme
        case color
        case emoji
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .theme)
        try container.encode(emoji, forKey: .emoji)
        try container.encode(uiColor.rgb, forKey: .color)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .theme)
        emoji = try container.decode([String].self, forKey: .emoji)
        let rgb = try container.decode(UIColor.RGB.self, forKey: .color)
        uiColor = .init(rgb)
    }
}
