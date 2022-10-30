//
//  NetworkService.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import Alamofire
import Combine
import Foundation

public class NetworkService {
    private var urlSession: URLSession
    private var session: Session
    private var baseURL: URL?
    
    public init(url: String, urlSession: URLSession = URLSession(configuration: URLSession.configuration())) {
        self.baseURL = URL(string: url)
        self.urlSession = urlSession
        self.session = Session(configuration: urlSession.configuration)
    }
    
    public func setBaseUrl(_ baseUrl: String) {
        baseURL = URL(string: baseUrl)
    }
    
    private func getHeaders<Response>(_ request: APIRequest<Response>) -> Alamofire.HTTPHeaders {
        var headers = Alamofire.HTTPHeaders.default
        
        headers["contentType"] = request.contentType.rawValue
        headers["accept"] = APIContentType.json.rawValue
        
        return headers
    }
    
    private func getBaseUrl(path: String, parameters: [String: Any] = [:]) -> URL? {
        guard let baseURL = baseURL?.appendingPathComponent(path) else { return nil }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }
        
        let url = URL(string: urlComponents.url?.absoluteString.removingPercentEncoding ?? "")
        
        return url
    }
    
    private func getURLRequest<Response>(_ endpoint: APIRequest<Response>) -> URLRequest? {
        var url: URL?
        var httpBody: Data?
        
        if let parameters = endpoint.parameters {
            if endpoint.method != .get {
                let body = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                httpBody = body
                url = getBaseUrl(path: endpoint.relativePath)
            } else {
                url = getBaseUrl(path: endpoint.relativePath, parameters: parameters)
            }
        } else {
            url = getBaseUrl(path: endpoint.relativePath)
        }
        
        guard let requestUrl: URL = url else { return nil }
        
        let headers = getHeaders(endpoint)
        
        var request = URLRequest(url: requestUrl)
        request.httpBody = httpBody
        request.allHTTPHeaderFields = headers.dictionary
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
}

extension NetworkService: NetworkServiceType {
    public func request<Response>(_ endpoint: APIRequest<Response>,
                                queue: DispatchQueue = .main,
                                retries: Int = 0) -> AnyPublisher<Response, Error> where Response: Decodable
    {
        guard let request = getURLRequest(endpoint) else {
            return Fail<Response, Error>(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        
        let result = urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NSError(domain: "", code: -1, userInfo: nil)
                }
                
                if !(200 ..< 300 ~= httpResponse.statusCode) {
                    
                    debugPrint("Error Endpoint: \(request.url?.absoluteString ?? "")")
                    
                    if var resString = String(data: data, encoding: .utf8) {
                        resString.removeAll(where: { $0 == "\\" })
                        debugPrint("** Error Response data: ** : \(resString)")
                    }
                    
                    throw NSError(domain: "", code: -1, userInfo: nil)
                }
                
                return data
            }
        
        if Response.self == Data.self {
            return result
                .tryMap { $0 as! Response }
                .receive(on: queue)
                .retry(retries)
                .mapError { $0 }
                .eraseToAnyPublisher()
        } else {
            return result
                .decode(type: Response.self, decoder: decoder)
                .receive(on: queue)
                .retry(retries)
                .mapError { $0 }
                .eraseToAnyPublisher()
        }
    }
    
    private func url(path: String) -> URL? {
        return baseURL?.appendingPathComponent(path)
    }
}
