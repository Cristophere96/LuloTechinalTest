//
//  PokemonsViewModel.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var selectedView: Constants.LayoutOption = .grid
    private var dependencies: InputDependencies
    
    struct InputDependencies {
        var getPokemonsInteractor: AnyInteractor<GenerationParams, [Pokemon]>
    }
    
    private var subscribers: Set<AnyCancellable> = []
    private var generationParams: GenerationParams
    
    init(dependencies: InputDependencies, limit: Int, offset: Int) {
        self.dependencies = dependencies
        self.generationParams = GenerationParams(limit: limit, offset: offset)
    }
    
    func fetchPokemons() {
        self.isLoading = true
        self.showError = false
        self.errorMessage = ""
        
        dependencies.getPokemonsInteractor.execute(params: self.generationParams)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.pokemons = []
                    self?.isLoading = false
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] pokemons in
                withAnimation {
                    self?.isLoading = false
                    self?.pokemons = pokemons
                    self?.pokemons.sort { $0.id < $1.id }
                }
            }
            .store(in: &subscribers)
    }
}
