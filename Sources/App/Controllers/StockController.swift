//
//  StockController.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import Vapor
import HTMLKitVapor

class StockController {
    func getIndex(_ request: Request) async throws -> Vapor.View {
        try await request.htmlkit.render(IndexView())
    }

    func getSearch(_ request: Request) async throws -> Vapor.View {
        let data = try request.content.decode(SearchPayload.self)

        let getStockData = Task {
            return try await Stock.get(search: data)
        }
        let stockData = try await getStockData.value
        return try await request.htmlkit.render(SearchView(stock: stockData))
    }
}

extension StockController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("", use: self.getIndex)
        routes.post("search", use: self.getSearch)
    }
}
