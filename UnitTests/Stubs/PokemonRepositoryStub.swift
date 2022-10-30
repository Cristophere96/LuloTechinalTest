//
//  PokemonRepositoryStub.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import Resolver
import Combine
@testable import Lulo_technical_test

final class PokemonRepositoryStub {
    static var error: Error?
    static var response: Any!
}

extension PokemonRepositoryStub: PokemonRepositoryType {
    func getPokemonsFromAGeneration(params: GenerationParams) -> AnyPublisher<[Pokemon], Error> {
        let data = PokemonRepositoryStub.response ?? TestsConstants.mockedPokemons
        let publisher = CurrentValueSubject<[Pokemon], Error>(data as? [Pokemon] ?? TestsConstants.mockedPokemons)
        
        if let error = PokemonRepositoryStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        let data = PokemonRepositoryStub.response ?? TestsConstants.mockedPokemon
        let publiser = CurrentValueSubject<Pokemon, Error>(data as? Pokemon ?? TestsConstants.mockedPokemon)
        
        if let error = PokemonRepositoryStub.error {
            publiser.send(completion: .failure(error))
        }
        return publiser.eraseToAnyPublisher()
    }
}
