//
//  SearchPayload.swift
//
//
//  Created by Peter Cammeraat on 12/11/2023.
//

import Vapor

struct SearchPayload: Content {
    let ticker: String
    let from: String
    let to: String
}
