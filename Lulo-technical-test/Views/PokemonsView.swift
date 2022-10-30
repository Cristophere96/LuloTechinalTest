//
//  PokemonsView.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI
import Resolver

struct PokemonsView: View {
    @ObservedObject var viewModel: PokemonViewModel
    let limit: Int
    let offset: Int
    let title: String
    
    init(limit: Int, offset: Int, title: String) {
        self.limit = limit
        self.offset = offset
        self.title = title
        self.viewModel = PokemonViewModel(
            dependencies: .init(getPokemonsInteractor: Resolver.resolve()),
            limit: limit,
            offset: offset
        )
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(
                    columns: viewModel.selectedView == .grid ? Constants.gridItems : Constants.listItem,
                    spacing: 16 )
                {
                    ForEach(viewModel.pokemons) { pokemon in
                        if viewModel.selectedView == .grid {
                            PokemonCell(pokemon: pokemon)
                        } else {
                            LargePokemonCell(pokemon: pokemon)
                        }
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .navigationTitle(title)
            }
            .toolbar {
                Menu {
                    Section {
                        Picker(selection: $viewModel.selectedView) {
                            ForEach(Constants.LayoutOption.allCases, id: \.rawValue) { view in
                                HStack {
                                    Text(view.rawValue)
                                    Spacer()
                                    Image(systemName: view.icon)
                                }
                                .tag(view)
                            }
                        } label: {
                            EmptyView()
                        }
                    }
                } label: {
                    Image(systemName: viewModel.selectedView.icon)
                }
            }
            if viewModel.isLoading {
                LoadingView()
            }
            if viewModel.showError {
                ErrorView(
                    buttonAction: { viewModel.fetchPokemons() },
                    errorMessage: viewModel.errorMessage
                )
            }
        }
        .onAppear() {
            if viewModel.pokemons.isEmpty {
                viewModel.fetchPokemons()
            }
        }
    }
}

struct PokemonsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonsView(limit: 151, offset: 0, title: "Generation 1")
    }
}
