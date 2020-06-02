//
//  Array+Single.swift
//  Memorize
//
//  Created by Holyberry on 28.05.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import GameplayKit

extension Array {
    var single: Element? {
        count == 1 ? first : nil
    }
}
