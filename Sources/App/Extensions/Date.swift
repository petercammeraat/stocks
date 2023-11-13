//
//  Date.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2023 Peter Cammeraat
//

import Vapor

extension Date {
    /// Converts date to string example: 2023-11-02
    var convertToOnlyDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
