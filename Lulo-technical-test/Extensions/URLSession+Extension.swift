//
//  URLSession+Extension.swift
//  Lulo-technical-test
//
//  Created by Cristopher Escorcia on 28/10/22.
//

import Foundation

public extension URLSession {
    static func configuration(
        timeOut: Int = 60,
        requestCahePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData
    ) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = requestCahePolicy
        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        return configuration
    }
}
