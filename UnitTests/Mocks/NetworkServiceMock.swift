//
//  NetworkServiceMock.swift
//  Lulo-technical-testTests
//
//  Created by Cristopher Escorcia on 30/10/22.
//

import Combine
import Foundation
@testable import Lulo_technical_test

final class NetworkServiceMock {
    static var error: Error?
    static var response: AnyObject!
}

extension NetworkServiceMock: NetworkServiceType {
    func request<Response>(_ endpoint: APIRequest<Response>, queue: DispatchQueue, retries: Int) -> AnyPublisher<Response, Error> where Response: Decodable {
        var respObject: Response! = nil
        
        if NetworkServiceMock.response != nil {
            respObject = NetworkServiceMock.response as? Response
        }
        
        let publisher = CurrentValueSubject<Response, Error>(respObject)

        if let error = NetworkServiceMock.error {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func upload<Response>(_ endpoint: APIRequest<Response>,
                          queue: DispatchQueue,
                          retries: Int,
                          fileName: String?,
                          fileExtension: String,
                          mimeType: String) -> AnyPublisher<Response, Error> where Response: Decodable {
        var respObject: Response! = nil
        
        if NetworkServiceMock.response != nil {
            respObject = NetworkServiceMock.response as? Response
        }
        
        let publisher = CurrentValueSubject<Response, Error>(respObject)

        if let error = NetworkServiceMock.error {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func setBaseUrl(_ baseUrl: String) {
        debugPrint(baseUrl)
    }
}
