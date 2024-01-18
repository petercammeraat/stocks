//
//  routes.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: StockController())
}
