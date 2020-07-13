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
        gameName = theme.rawValue
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
        let randomTheme = Theme.allCases.randomElement() ?? .halloween
        model = EmojiMemoryGame.createMemoryGame(emoji: randomTheme.emoji)
        gameName = randomTheme.rawValue
        cardColor = randomTheme.color
        topColor = randomTheme.uiColor.darker(0.15)
        print(randomTheme.getJson())
    }
}

extension Theme {
    var color: Color {
        return Color(uiColor)
    }
    
    var uiColor: UIColor {
        switch self {
        case .halloween: return .systemOrange
        case .sport: return .systemBlue
        case .animals: return .systemGreen
        case .faces: return .systemYellow
        case .transport: return .systemGray
        case .food: return .systemPink
        case .tiktok: return UIColor.black.lighter(0.25)
        }
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
        try container.encode(self.rawValue, forKey: .theme)
        try container.encode(emoji, forKey: .emoji)
        try container.encode(uiColor.rgb, forKey: .color)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .theme)
        self = Theme(rawValue: name)!
    }
}
