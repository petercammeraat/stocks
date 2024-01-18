//
//  SearchView.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import HTMLKit
import HTMLKitComponents

struct SearchView: View {
    let stock: Stock
    let reversedResults: [Stock.Result]
    let highestClosingPrice: Double

    var body: Content {
        BaseView {
            Main {
                SearchForm()

                Div {
                    H1 { stock.ticker }
                    StockChart(stock: stock, highestClosingPrice: highestClosingPrice)
                    StockTable(reversedResults: reversedResults)
                }
                .id("results")
            }
        }
    }

    init(stock: Stock) {
        self.stock = stock
        reversedResults = stock.results.reversed()
        highestClosingPrice = stock.results.map { $0.closingPrice }.max() ?? 0
    }
}
