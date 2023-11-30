//
//  HTMXController.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2023 Peter Cammeraat
//

import Vapor
import WebHTMX

class HTMXController {
    static func makeIndex() -> Vapor.Data {
        let today = Date().convertToOnlyDate
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())?.convertToOnlyDate

        var doc: Document {
            Document(.html) {
                Html(lang: Lang(.en, .gb)) {
                    Head {
                        Title("Stocks")
                        Meta().charset("utf-8")
                        Meta().name(.viewport).content("width=device-width, initial-scale=1")
                        Script().src("https://unpkg.com/htmx.org@1.9.8")
                        Link(rel: .stylesheet).href("styles.css").type("text/css")
                    }

                    Body {
                        Main {
                            Form {
                                Label("Ticker:")
                                Input()
                                    .type(.text)
                                    .name("ticker")
                                    .id("ticker")

                                Label("From date:")
                                Input()
                                    .type(.date)
                                    .name("from")
                                    .id("from")
                                    .value(sevenDaysAgo)

                                Label("To date:")
                                Input()
                                    .type(.date)
                                    .name("to")
                                    .id("to")
                                    .value(today)

                                Button("Search")
                                    .type(.submit)

                            }
                            .hxPost("/search")
                            .hxTarget(target: .next)
                            .hxSwap(swap: .outerHTML)

                            Div()
                                .id("results")
                        }
                    }
                }
            }
        }

        let html = DocumentRenderer(minify: false).render(doc)
        return html.data(using: .utf8) ?? Data()
    }


    static func searchResponse(stock: Stock) -> Vapor.Data {
        let reversedResults = stock.results.reversed()
        let highestClosingPrice = stock.results.map { $0.closingPrice }.max() ?? 0

        var chart: Element {
            Div {
                Table {
                    Thead {
                        Tr {
                            Th("Date")
                                .scope(.col)
                            Th("Value")
                                .scope(.col)
                        }
                    }

                    Tbody {
                        for result in stock.results {
                            Tr {
                                Th(result.timestamp.convertToReadableDate)
                                    .scope(.row)
                                Td {
                                    Span("\(result.closingPrice)")
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

        var table: Element {
            Table {
                Tr {
                    Th("Date")
                    Th("Closing Price")
                    Th("Highest Price")
                    Th("Lowest Price")
                    Th("Open Price")
                    Th("Transactions")
                    Th("Volume")
                    Th("Volume Weight")
                }

                for result in reversedResults {
                    Tr {
                        Td("\(result.timestamp.convertToReadableDate)")
                        Td("\(result.closingPrice)")
                        Td("\(result.highestPrice)")
                        Td("\(result.lowestPrice)")
                        Td("\(result.openPrice)")
                        Td("\(result.numberOfTransactions)")
                        Td("\(result.volume)")
                        Td("\(result.volumeWeighted)")
                    }
                }
            }
        }

        var doc: Document {
            Document(.unspecified) {
                Div {
                    H1(stock.ticker)

                    Comment("Chart")
                    chart

                    Comment("Table")
                    table
                }
                .id("results")
            }
        }

        let html = DocumentRenderer(minify: false).render(doc)
        return html.data(using: .utf8) ?? Data()
    }
}
