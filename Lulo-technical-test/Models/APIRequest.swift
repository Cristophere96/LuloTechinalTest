//
//  APIRequest.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import Foundation
import Alamofire

public class APIRequest<Response> {
    public let method: HTTPMethod
    public let relativePath: String
    public let parameters: [String: Any]?
    public let parameterEncoding: ParameterEncoding
    public let decode: (Data) throws -> Response
    public let authorizationToken: String?
    public let contentType: APIContentType

    public init(method: HTTPMethod = .get,
                relativePath: String, parameters: [String: Any]? = nil,
                parameterEncoding: ParameterEncoding = URLEncoding.default,
                authorizationToken: String? = nil,
                contentType: APIContentType = APIContentType.json,
                decode: @escaping (Data) throws -> Response)
    {
        self.method = method
        self.relativePath = relativePath
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
        self.decode = decode
        self.authorizationToken = authorizationToken
        self.contentType = contentType
    }
}

public extension APIRequest where Response: Decodable {
    convenience init(method: HTTPMethod = .get,
                     relativePath: String,
                     parameters: [String: Any]? = nil,
                     parameterEncoding: ParameterEncoding = URLEncoding.default,
                     authorizationToken: String? = nil,
                     contentType: APIContentType = APIContentType.json)
    {
        self.init(method: method,
                  relativePath: relativePath,
                  parameters: parameters,
                  parameterEncoding: parameterEncoding,
                  authorizationToken: authorizationToken,
                  contentType: contentType) {
            let decoder = JSONDecoder()
            return try decoder.decode(Response.self, from: $0)
        }
    }
}
