//
//  App+Injection.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        typealias GetPokemonInteractor = AnyInteractor<GenerationParams, [Pokemon]>
        
        register(NetworkServiceType.self) {
            NetworkService(url: Constants.urlsName.pokemonURLBase)
        }
        
        register(PokemonRepositoryType.self) { resolver in
            PokemonRepository(networkService: resolver.resolve(NetworkServiceType.self))
        }
        
        register(GetPokemonInteractor.self) { resolver in
            GetPokemonsInteractor(pokemonRepository: resolver.resolve(PokemonRepositoryType.self))
        }
    }
}
