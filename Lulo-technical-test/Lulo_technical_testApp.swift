//
//  Lulo_technical_testApp.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI

@main
struct Lulo_technical_testApp: App {
    
    init() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GenerationsView()
            }
        }
    }
}
