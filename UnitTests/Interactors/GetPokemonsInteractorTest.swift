//
//  GetPokemonsInteractorTest.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import XCTest
import Combine
@testable import Lulo_technical_test

final class GetPokemonsInteractorTest: XCTestCase {
    private var pokemonRepository: PokemonRepositoryStub!
    private var sut: AnyInteractor<GenerationParams, [Pokemon]>!
    
    override func setUpWithError() throws {
        pokemonRepository = PokemonRepositoryStub()
        sut = GetPokemonsInteractor(pokemonRepository: pokemonRepository)
    }
    
    override func tearDownWithError() throws {
        pokemonRepository = nil
        sut = nil
        PokemonRepositoryStub.error = nil
        PokemonRepositoryStub.response = nil
        super.tearDown()
    }
    
    func test_interactorFetchPokemonsFromAGeneration_WhenIsSuccess() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        expectationFailure.isInverted = true
        
        PokemonRepositoryStub.response = TestsConstants.mockedPokemons
        
        let cancellable = sut.execute(params: GenerationParams(limit: 9, offset: 151))
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
            }, receiveValue: { pokemons in
                XCTAssertFalse(pokemons.isEmpty)
                XCTAssert(pokemons.count == 9)
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 0.5)
        cancellable.cancel()
    }
    
    func test_interactorFetchPokemonsFromAGeneration_WhenIsFailure() {
        let expectationFailure = XCTestExpectation(description: "failure")
        let expectation = XCTestExpectation(description: "Consume api and returns a list of Pokemons")
        expectation.isInverted = true
        
        PokemonRepositoryStub.error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad request"])
        
        let cancellable = sut.execute(params: GenerationParams(limit: 9, offset: 151))
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else {
                    return XCTFail("completion is not failure")
                }
                XCTAssertEqual(error.localizedDescription, "Bad request")
                expectationFailure.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
        
        self.wait(for: [expectation, expectationFailure], timeout: 0.5)
        cancellable.cancel()
    }
}
