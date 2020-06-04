//
//  Theme.swift
//  Memorize
//
//  Created by Holyberry on 04.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

enum Theme: String, CaseIterable {
    case halloween = "Halloween"
    case sport = "Sport"
    case animals = "Animals"
    case faces = "Faces"
    case transport = "Transport"
    case food = "Food"
    
    var emoji: [String] {
        switch self {
        case .halloween:
            return ["👻", "💀", "👽", "👾", "👹", "😈", "🎃", "💩", "🤖", "🦇", "🐙", "🕷"]
        case .animals:
            return ["🐶", "🐱", "🐭", "🦊", "🐻", "🐼", "🐨", "🐷", "🐧", "🙊", "🦆", "🐓"]
        case .transport:
            return ["🚗", "🚌", "🚓", "🚑", "🚒", "🚲", "🛵", "✈️", "🚅", "⛵️", "🛳", "🚊"]
        case .faces:
            return ["😁", "😎", "😒", "🥵", "😨", "😍", "😂", "😖", "🤭", "😡", "🤗", "😋"]
        case .food:
            return ["🍟", "🌮", "🍕", "🥓", "🥗", "🥟", "🍣", "🥯", "🥐", "🍗", "🧆", "🍝"]
        case .sport:
            return ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🥏", "🏓", "🏏", "🥊", "🥌"]
        }
    }
}
