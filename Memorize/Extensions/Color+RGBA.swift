//
//  Color+RGBA.swift
//  Memorize
//
//  Created by Holyberry on 12.07.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

extension Color {
    init(rgb: UIColor.RGB) {
        self.init(UIColor(rgb))
    }
}

extension UIColor {
    struct RGB: Hashable, Codable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }
    
    convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }
    
    var rgb: RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red,
               green: &green,
               blue: &blue,
               alpha: &alpha)
        return .init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
