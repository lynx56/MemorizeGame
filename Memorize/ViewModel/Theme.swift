//
//  Theme.swift
//  Memorize
//
//  Created by Holyberry on 04.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

struct Theme {
    var name: String
    var emoji: [String]
    var uiColor: UIColor
}

extension Theme {
    static var halloween = Theme(name: "Halloween",
                                 emoji: ["👻", "💀", "👽", "👾", "👹", "😈", "🎃", "💩", "🤖", "🦇", "🐙", "🕷"],
                                 uiColor: .systemOrange)
    static var sport = Theme(name: "Sport",
                             emoji: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🥏", "🏓", "🏏", "🥊", "🥌"],
                             uiColor: .systemBlue)
    static var animals = Theme(name: "Animals",
                               emoji: ["🐶", "🐱", "🐭", "🦊", "🐻", "🐼", "🐨", "🐷", "🐧", "🙊", "🦆", "🐓"],
                               uiColor: .systemGreen)
    static var faces = Theme(name: "Faces",
                             emoji: ["😁", "😎", "😒", "🥵", "😨", "😍", "😂", "😖", "🤭", "😡", "🤗", "😋"],
                             uiColor: .systemYellow)
    static var transport = Theme(name: "Transport",
                                 emoji: ["🚗", "🚌", "🚓", "🚑", "🚒", "🚲", "🛵", "✈️", "🚅", "⛵️", "🛳", "🚊"],
                                 uiColor: .systemGray)
    static var food = Theme(name: "Food",
                            emoji: ["🍟", "🌮", "🍕", "🥓", "🥗", "🥟", "🍣", "🥯", "🥐", "🍗", "🧆", "🍝"],
                            uiColor: .systemPink)
    static var tiktok = Theme(name: "Tiktok",
                              emoji: ["🗿", "🗿", "👑", "👑", "🤡", "🔥"],
                              uiColor: UIColor.black.lighter(0.25))
}


extension Theme {
    var color: Color {
        return Color(uiColor)
    }
}
