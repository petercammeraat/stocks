//
//  StockChart.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import Foundation
import HTMLKit
import HTMLKitComponents

struct StockChart: View {
    let stock: Stock
    let highestClosingPrice: Double

    var body: Content {
        Div {
            Table {
                Thead {
                    Tr {
                        Th {
                            "Date"
                        }
                        .scope("col")

                        Th {
                            "Value"
                        }
                        .scope("col")
                    }
                }

                Tbody {
                    for result in stock.results {
                        Tr {
                            Th {
                                result.timestamp.convertToReadableDate
                            }
                            .scope("row")

                            Td {
                                Span {
                                    "\(result.closingPrice)"
                                }
                                .class("data")
                            }
                            .style("--size: \(result.closingPrice / highestClosingPrice)")
                        }

                    }
                }

            }
            .class("charts-css column show-labels show-primary-axis show-5-secondary-axes data-spacing-4")
        }
        .id("stock-chart")
    }
}
