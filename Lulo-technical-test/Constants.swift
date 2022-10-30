//
//  Constants.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI

public struct Constants {
    enum urlsName {
        static let pokemonURLBase = "https://pokeapi.co/api/v2/pokemon"
    }
    
    enum DetailOptions: String, CaseIterable {
        case GENERAL = "General"
        case STATS = "Stats"
        case MOVES = "Moves"
    }
    
    enum LayoutOption: String, Codable, CaseIterable {
        case list = "List"
        case grid = "Grid"
        
        var icon: String {
            switch self {
            case .list: return "list.dash"
            case .grid: return "square.grid.2x2"
            }
        }
    }
    
    static let listItem = [GridItem(.flexible())]
    
    static let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
}
