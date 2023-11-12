//
//  Stock.swift
//
//
//  Created by Peter Cammeraat on 08/11/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Vapor

struct Stock: Codable {
    /// Whether or not this response was adjusted for splits.
    let adjusted: Bool

    /// If present, this value can be used to fetch the next page of data.
    let nextURL: String?

    /// The number of aggregates (minute or day) used to generate the response.
    let queryCount: Int

    /// A request id assigned by the server.
    let requestID: String

    /// Results
    let results: [Stock.Result]

    /// The total number of results for this request.
    let resultsCount: Int

    /// The status of this request's response.
    let status: String

    /// The exchange symbol that this item is traded under.
    let ticker: String

    enum CodingKeys: String, CodingKey {
        case adjusted
        case nextURL = "next_url"
        case queryCount
        case requestID = "request_id"
        case results
        case resultsCount
        case status
        case ticker
    }
}

// MARK: - Other structs
extension Stock {
    struct Result: Codable {
        /// The close price for the symbol in the given time period.
        let closingPrice: Double

        /// The highest price for the symbol in the given time period.
        let highestPrice: Double

        /// The lowest price for the symbol in the given time period.
        let lowestPrice: Double

        /// The number of transactions in the aggregate window.
        let numberOfTransactions: Int

        /// The open price for the symbol in the given time period.
        let openPrice: Double

        /// The Unix Msec timestamp for the start of the aggregate window.
        let timestamp: Int

        /// The trading volume of the symbol in the given time period.
        let volume: Int

        /// The volume weighted average price.
        let volumeWeighted: Double

        enum CodingKeys: String, CodingKey {
            case closingPrice = "c"
            case highestPrice = "h"
            case lowestPrice = "l"
            case numberOfTransactions = "n"
            case openPrice = "o"
            case timestamp = "t"
            case volume = "v"
            case volumeWeighted = "vw"
        }
    }
}

// MARK: - Methods
extension Stock {
    @Sendable static func get(search: SearchPayload) async throws -> Stock {
        let apiKey = Environment.get("API_KEY") ?? "no key found"
        let baseUrl = "https://api.polygon.io/v2/"
        let api = "aggs/ticker/\(search.ticker.uppercased())/range/1/day/\(search.from)/\(search.to)?apiKey=\(apiKey)"

        let url = URL(string: baseUrl + api)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Stock.self, from: data)
    }
}
