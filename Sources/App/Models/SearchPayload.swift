//
//  SearchPayload.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2023 Peter Cammeraat
//

import Vapor

struct SearchPayload: Content {
    let ticker: String
    let from: String
    let to: String
}
