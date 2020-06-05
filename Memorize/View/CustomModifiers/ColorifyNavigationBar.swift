//
//  NavigationBarColored.swift
//  Memorize
//
//  Created by Holyberry on 05.06.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import SwiftUI

extension View {
    func navigationBarColor(_ backgroundColor: UIColor) -> some View {
        self.modifier(ColorifyNavigationBar(backgroundColor: backgroundColor))
    }
}

struct ColorifyNavigationBar: ViewModifier {
        
    private let backgroundColor: UIColor
    
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.standardAppearance = coloredAppearance
        navigationBarAppearance.compactAppearance = coloredAppearance
        navigationBarAppearance.scrollEdgeAppearance = coloredAppearance
        navigationBarAppearance.tintColor = .white
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

