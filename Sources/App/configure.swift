//
//  configure.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2023 Peter Cammeraat
//

import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
}
