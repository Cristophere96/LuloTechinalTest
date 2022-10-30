//
//  PokemonsViewModelTest.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import XCTest
@testable import Lulo_technical_test

final class PokemonsViewModelTest: XCTestCase {
    private var getPokemonsStub: GetPokemonsInteractorStub!
    private var sut: PokemonViewModel!

    override func setUpWithError() throws {
        getPokemonsStub = GetPokemonsInteractorStub()
        let dependencies = PokemonViewModel.InputDependencies(getPokemonsInteractor: getPokemonsStub)
        sut = PokemonViewModel(dependencies: dependencies, limit: 9, offset: 151)
    }

    override func tearDownWithError() throws {
        getPokemonsStub = nil
        sut = nil
    }
    
    func test_GivenALimitAndAnOffsetThenFetchPokemonGeneration_WhenIsSuccess() {
        let expectation = XCTestExpectation(description: "Given a limit of 9 and an offset of 151 gets the main pokemons from the second generation")
        
        getPokemonsStub.responseHandler = .success {
            TestsConstants.mockedPokemons
        }
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.pokemons.isEmpty)
            XCTAssert(sut.pokemons.count ==  9)
            XCTAssertFalse(sut.isLoading)
        } else {
            XCTFail("test failed due to timeout")
        }
    }
    
    func test_GivenALimitAndAnOffsetThenFetchPokemonGeneration_WhenIsFailure() {
        let expectation = XCTestExpectation(description: "shows error due to bad internet connection")
        
        getPokemonsStub.responseHandler = .failure({
            NSError(domain: "", code: 504, userInfo: [NSLocalizedDescriptionKey: "The internet seems to be off"])
        })
        sut.fetchPokemons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.pokemons.isEmpty)
            XCTAssertFalse(sut.isLoading)
            XCTAssertTrue(sut.showError)
            XCTAssert(sut.errorMessage == "The internet seems to be off")
        } else {
            XCTFail("test failed due to timeout")
        }
    }
}
