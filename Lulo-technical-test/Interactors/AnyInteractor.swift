//
//  AnyInteractor.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import Foundation
import Combine

protocol Interactorable {
    associatedtype Response
    associatedtype Params

    func execute(params: Params) -> AnyPublisher<Response, Error>
}

open class AnyInteractor<Input, Output>: Interactorable {
    public typealias Response = Output
    public typealias Params = Input

    open func execute(params: Input) -> AnyPublisher<Output, Error> {
        fatalError("This method must be implemented")
    }
}
