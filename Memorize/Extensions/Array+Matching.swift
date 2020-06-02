//
//  Array+Shuffle.swift
//  Memorize
//
//  Created by Holyberry on 28.05.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import GameplayKit

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        return self.firstIndex(where: { $0.id == matching.id })
    }
}
