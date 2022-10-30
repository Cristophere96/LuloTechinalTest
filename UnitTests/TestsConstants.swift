//
//  TestsConstants.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import SwiftUI
@testable import Lulo_technical_test

public struct TestsConstants {
    static let mockedMoves: [Move] = [
        Move(move: Species(name: "cut", url: "https://pokeapi.co/api/v2/move/15/")),
        Move(move: Species(name:"double-kick", url:"https://pokeapi.co/api/v2/move/24/")),
        Move(move: Species(name:"headbutt", url:"https://pokeapi.co/api/v2/move/29/")),
        Move(move: Species(name:"tackle", url:"https://pokeapi.co/api/v2/move/33/")),
        Move(move: Species(name:"body-slam", url:"https://pokeapi.co/api/v2/move/34/"))
    ]
    
    static let mockedSprites = Sprites(
        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/155.png",
        other: nil
    )
    
    static let mockedTypes: [TypeElement] = [
        TypeElement(slot: 1, type: Species(name: "fire", url: "https://pokeapi.co/api/v2/type/10/"))
    ]
    
    static let mockedPokemonURL = "https://pokeapi.co/api/v2/pokemon/155"
    
    static let mockedPokemon = Pokemon(height: 5, id: 155, moves: mockedMoves, name: "cyndaquill", sprites: mockedSprites, types: mockedTypes, weight: 79, stats: [])
    
    static let mockedPokemons: [Pokemon] = [
        Pokemon(height: 9, id: 152, moves: mockedMoves, name: "chikorita", sprites: mockedSprites, types: mockedTypes, weight: 64, stats: []),
        Pokemon(height: 12, id: 153, moves: mockedMoves, name: "bayleef", sprites: mockedSprites, types: mockedTypes, weight: 158, stats: []),
        Pokemon(height: 18, id: 154, moves: mockedMoves, name: "meganium", sprites: mockedSprites, types: mockedTypes, weight: 1005, stats: []),
        Pokemon(height: 5, id: 155, moves: mockedMoves, name: "cyndaquill", sprites: mockedSprites, types: mockedTypes, weight: 79, stats: []),
        Pokemon(height: 9, id: 156, moves: mockedMoves, name: "quilava", sprites: mockedSprites, types: mockedTypes, weight: 190, stats: []),
        Pokemon(height: 17, id: 157, moves: mockedMoves, name: "typhlosion", sprites: mockedSprites, types: mockedTypes, weight: 795, stats: []),
        Pokemon(height: 6, id: 158, moves: mockedMoves, name: "totodile", sprites: mockedSprites, types: mockedTypes, weight: 95, stats: []),
        Pokemon(height: 11, id: 159, moves: mockedMoves, name: "croconaw", sprites: mockedSprites, types: mockedTypes, weight: 250, stats: []),
        Pokemon(height: 23, id: 160, moves: mockedMoves, name: "feraligatr", sprites: mockedSprites, types: mockedTypes, weight: 888, stats: []),
    ]
    
    static let mockedPokedex: Pokedex = {
        Pokedex(results: [
            Results(name: "chikorita", url: "https://pokeapi.co/api/v2/pokemon/152"),
            Results(name: "bayleef", url: "https://pokeapi.co/api/v2/pokemon/153"),
            Results(name: "meganium", url: "https://pokeapi.co/api/v2/pokemon/154"),
            Results(name: "cyndaquill", url: "https://pokeapi.co/api/v2/pokemon/155"),
            Results(name: "quilava", url: "https://pokeapi.co/api/v2/pokemon/156"),
            Results(name: "typhlosion", url: "https://pokeapi.co/api/v2/pokemon/157"),
            Results(name: "totodile", url: "https://pokeapi.co/api/v2/pokemon/158"),
            Results(name: "croconaw", url: "https://pokeapi.co/api/v2/pokemon/159"),
            Results(name: "feraligatr", url: "https://pokeapi.co/api/v2/pokemon/160")
        ])
    }()
}
