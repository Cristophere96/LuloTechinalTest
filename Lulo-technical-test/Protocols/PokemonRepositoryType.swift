//
//  PokemonRepositoryType.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI
import Combine

protocol PokemonRepositoryType {
    func getPokemonsFromAGeneration(params: GenerationParams) -> AnyPublisher<[Pokemon], Error>
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>
}
