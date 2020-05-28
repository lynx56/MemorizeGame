//
//  Array+Shuffle.swift
//  Memorize
//
//  Created by Holyberry on 28.05.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import GameplayKit

extension Array {
    func shuffled(using source: GKRandomSource) -> [Element] {
        return (self as NSArray).shuffled(using: source) as! [Element]
    }
}
