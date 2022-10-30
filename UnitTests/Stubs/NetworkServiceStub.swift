//
//  NetworkServiceStub.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import Combine
import Foundation
import Lulo_technical_test

class NetworkServiceStub<Resp: Decodable>: NetworkServiceType {
    var response: Resp!
    var error: Error?
    
    private func publish<Response: Decodable>() -> AnyPublisher<Response, Error> {
        if response == nil, error == nil {
            fatalError("Both values can not be nil")
        }
        
        let subject = CurrentValueSubject<Response, Error>(response as! Response)
        
        if let error = error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }

    func request<Response>(_ endpoint: APIRequest<Response>,
                           queue: DispatchQueue,
                           retries: Int) -> AnyPublisher<Response, Error> where Response: Decodable
    {
        publish()
    }
    
    func upload<Response>(_ endpoint: APIRequest<Response>,
                          queue: DispatchQueue,
                          retries: Int,
                          fileName: String?,
                          fileExtension: String,
                          mimeType: String) -> AnyPublisher<Response, Error> where Response: Decodable
    {
        publish()
    }
    
    func setBaseUrl(_ baseUrl: String) {
        print(baseUrl)
    }
    
    func clear() {
        error = nil
        response = nil
    }
}
