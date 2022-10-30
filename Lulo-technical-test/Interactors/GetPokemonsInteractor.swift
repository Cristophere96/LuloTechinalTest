//
//  GetPokemonsInteractor.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI
import Combine

class GetPokemonsInteractor: AnyInteractor<GenerationParams, [Pokemon]> {
    var pokemonRepository: PokemonRepositoryType
    
    init(pokemonRepository: PokemonRepositoryType) {
        self.pokemonRepository = pokemonRepository
    }
    
    public override func execute(params: GenerationParams) -> AnyPublisher<[Pokemon], Error> {
        return pokemonRepository.getPokemonsFromAGeneration(params: params)
    }
}
