//
//  PokemonRepositoryTest.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import XCTest
import Combine
@testable import Lulo_technical_test

final class PokemonRepositoryTest: XCTestCase {
    private var sut: PokemonRepositoryType!
    private var networkService: NetworkServiceStub<Pokemon>!

    override func setUpWithError() throws {
        networkService = .init()
        sut = PokemonRepository(networkService: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService.error = nil
        networkService.response = nil
        super.tearDown()
    }

    func test_repositoryFetchListOfPokemons_WhenIsSuccess() {
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        networkService.response = .init(TestsConstants.mockedPokemon)
        
        let cancellable = sut.getASinglePokemon(url: TestsConstants.mockedPokemonURL)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
            }, receiveValue: { pokemon in
                XCTAssertNotNil(pokemon)
                XCTAssertEqual(pokemon.name, TestsConstants.mockedPokemon.name)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation], timeout: 0.5)
        cancellable.cancel()
    }
}
