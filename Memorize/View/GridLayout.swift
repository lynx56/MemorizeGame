//
//  GridLayout.swift
//  Memorize
//
//  Created by Holyberry on 28.05.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

struct GridLayout {
    private(set)var size: CGSize
    private(set)var rowCount: Int = 0
    private(set)var columnCount: Int = 0
    private let offset: CGFloat = 0.5
    
    init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize) {
        self.size = size
        guard size.width > 0, size.height > 0, itemCount > 0 else { return }
        
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
        var smallestVariance: Double?
        let sizeAspectRatio = abs(Double(size.width/size.height))
        for rows in 1...itemCount {
            let columns = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)
            if (rows - 1) * columns < itemCount {
                let itemAspectRatio = sizeAspectRatio * (Double(rows)/Double(columns))
                let variance = abs(itemAspectRatio - desiredAspectRatio)
                if smallestVariance == nil || variance < smallestVariance! {
                    smallestVariance = variance
                    bestLayout = (rowCount: rows, columnCount: columns)
                }
            }
        }
        rowCount = bestLayout.rowCount
        columnCount = bestLayout.columnCount
    }
    
    var itemSize: CGSize {
        guard rowCount > 0, columnCount > 0 else { return .zero }
        
        return .init(width: size.width / CGFloat(columnCount), height: size.height / CGFloat(rowCount))
    }
    
    func location(ofItemAt index: Int) -> CGPoint {
        guard rowCount > 0, columnCount > 0 else { return .zero }
        
        let x = (CGFloat(index % columnCount) + offset) * itemSize.width
        let y = (CGFloat(index / columnCount) + offset) * itemSize.height
        return .init(x: x, y: y)
    }
}
