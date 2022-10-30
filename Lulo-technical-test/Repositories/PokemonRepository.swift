//
//  PokemonRepository.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI
import Combine

class PokemonRepository: PokemonRepositoryType {
    var networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func getPokemonsFromAGeneration(params: GenerationParams) -> AnyPublisher<[Pokemon], Error> {
        let endpoint = APIRequest<Pokedex>(
            method: .get,
            relativePath: "?limit=\(params.limit)&offset=\(params.offset)"
        )
        
        return networkService.request(endpoint, queue: .main, retries: 0)
            .map { $0.results.map { self.getASinglePokemon(url: $0.url ?? "") } }
            .flatMap({ pokedex in
                Publishers.MergeMany(pokedex)
            })
            .collect()
            .eraseToAnyPublisher()
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        let endpoint = APIRequest<Pokemon>(
            method: .get,
            relativePath: "\(url.split(separator: Constants.urlsName.pokemonURLBase).last ?? "")"
        )
        
        return networkService.request(endpoint, queue: .main, retries: 0)
    }
}
