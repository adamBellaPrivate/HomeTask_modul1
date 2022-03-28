//
//  DataListRequest.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import Foundation

struct DataListRequest: ApiRequest {
    var path: String {
        "/strings"
    }
    private(set) var queryItems: [String: Any]?

    init(parameters: QueryParameters) {
        guard let data = try? JSONEncoder().encode(parameters) else {
            queryItems = nil
            return
        }
        queryItems = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
    }

    struct QueryParameters: Codable {
        let number = 10
        let length = 8
        let digits = "on"
        let upperalpha = "on"
        let loweralpha = "on"
        let unique = "on"
        let format = "plain"
        let random = "new"

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case number = "num"
            case length = "len"
            case digits
            case upperalpha
            case loweralpha
            case unique
            case format
            case random = "rnd"
        }
    }
}
