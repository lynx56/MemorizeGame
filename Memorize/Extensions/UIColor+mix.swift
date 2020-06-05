//
//  UIColor+mix.swift
//  Memorize
//
//  Created by Holyberry on 05.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

extension UIColor {

    func lighter(_ amount: CGFloat = 0.25) -> UIColor {
        return mixWithColor(.white, amount: amount)
    }

    func darker(_ amount: CGFloat = 0.25) -> UIColor {
        return mixWithColor(.black, amount: amount)
    }

    func mixWithColor(_ color: UIColor, amount: CGFloat = 0.25) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, alpha1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, alpha2: CGFloat = 0
        
        getRed (&r1, green: &g1, blue: &b1, alpha: &alpha1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &alpha2)
        
        let mix: (CGFloat, CGFloat) -> CGFloat = { $0 * (1.0 - amount ) + $1 * amount }
        
        return UIColor(red: mix(r1, r2),
                       green: mix(g1, g2),
                       blue: mix(b1, b2),
                       alpha: alpha1)
    }
}
