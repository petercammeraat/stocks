//
//  Int.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2023 Peter Cammeraat
//

import Vapor

extension Int {
    var convertToReadableDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
