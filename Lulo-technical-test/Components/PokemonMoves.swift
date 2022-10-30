//
//  PokemonMoves.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import SwiftUI

struct PokemonMoves: View {
    var pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(pokemon.moves.prefix(20), id: \.move.name) { move in
                Text(move.move.name.capitalized)
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
        }
    }
}
