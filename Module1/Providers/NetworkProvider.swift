//
//  NetworkProvider.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import Foundation

protocol ApiRequest {
    var path: String { get }
    var queryItems: [String: Any]? { get }
}

protocol NetworkProviding {
    func request(_ request: ApiRequest) async -> Result<Data, Error>
}

struct NetworkProvider: NetworkProviding {
    private static let baseURL = "https://www.random.org"

    func request(_ request: ApiRequest) async -> Result<Data, Error> {
        guard let targetURL = buildURL(request), let data = try? Data(contentsOf: targetURL) else {
            return .failure(NSError())
        }

        return .success(data)
    }

    func buildURL(_ request: ApiRequest) -> URL? {
        var urlComponents = URLComponents(string: Self.baseURL)
        urlComponents?.path = request.path
        urlComponents?.queryItems = request.queryItems?.compactMap { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }

        return urlComponents?.url
    }
}
