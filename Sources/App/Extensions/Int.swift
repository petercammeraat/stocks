//
//  File.swift
//  
//
//  Created by Peter Cammeraat on 12/11/2023.
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
