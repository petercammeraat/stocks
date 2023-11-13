//
//  routes.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2023 Peter Cammeraat
//

import Vapor

func routes(_ app: Application) throws {
    app.get { req -> Response in
        let htmlData = HTMXController.makeIndex()

        let response = Response(status: .ok)
        response.headers.contentType = .html
        response.body = Response.Body(data: htmlData)

        return response
    }
    .description("Index page")

    app.post("search") { req -> Response in
        let data = try req.content.decode(SearchPayload.self)

        let getStockData = Task {
            return try await Stock.get(search: data)
        }

        let stockData = try await getStockData.value
        let htmlData = HTMXController.searchResponse(stock: stockData)

        let response = Response(status: .ok)
        response.headers.contentType = .html
        response.body = Response.Body(data: htmlData)

        return response
    }
    .description("Search stocks")
}
