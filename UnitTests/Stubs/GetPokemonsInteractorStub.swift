//
//  GetPokemonsInteractorStub.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import Resolver
import Combine
@testable import Lulo_technical_test

final class GetPokemonsInteractorStub: AnyInteractor<GenerationParams, [Pokemon]> {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    var responseHandler: InteractorStubCase<Any> = .success({})
    
    override func execute(params: GenerationParams) -> AnyPublisher<[Pokemon], Error> {
        let objects = TestsConstants.mockedPokemons
        
        var publisher = CurrentValueSubject<[Pokemon], Error>(objects)
        
        switch responseHandler {
        case .success(let handler):
            publisher = CurrentValueSubject<[Pokemon], Error>(handler() as? [Pokemon] ?? objects )
        case .failure(let error):
            publisher.send(completion: .failure(error()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
