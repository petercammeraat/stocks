//
//  SearchForm.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import Foundation
import HTMLKit
import HTMLKitComponents

struct SearchForm: View {
    private let ticker = "ticker"
    private let from = "from"
    private let to = "to"

    private let today = Date().convertToOnlyDate
    private let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!.convertToOnlyDate

    var body: Content {
        Form {
            Label {
                "Ticker:"
            }
            Input()
                .type(.text)
                .name(ticker)
                .id(ticker)

            Label {
                "From date:"
            }
            Input()
                .type(.date)
                .name(from)
                .id(from)
                .value(sevenDaysAgo)

            Label {
                "To date:"
            }
            Input()
                .type(.date)
                .name(to)
                .id(to)
                .value(today)

            Button {
                "Search"
            }
            .type(.submit)
        }
        .method(.post)
        .action("/search")
    }
}
