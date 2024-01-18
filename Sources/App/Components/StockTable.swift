//
//  StockTable.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import Foundation
import HTMLKit
import HTMLKitComponents

struct StockTable: View {
    let reversedResults: [Stock.Result]

    var body: Content {
        Table {
            Tr {
                Th { "Date" }
                Th { "Closing Price" }
                Th { "Highest Price" }
                Th { "Lowest Price" }
                Th { "Open Price" }
                Th { "Transactions" }
                Th { "Volume" }
                Th { "Volume Weight" }
            }

            for result in reversedResults {
                Tr {
                    Td { "\(result.timestamp.convertToReadableDate)" }
                    Td { "\(result.closingPrice)" }
                    Td { "\(result.highestPrice)" }
                    Td { "\(result.lowestPrice)" }
                    Td { "\(result.openPrice)" }
                    Td { "\(result.numberOfTransactions)" }
                    Td { "\(result.volume)" }
                    Td { "\(result.volumeWeighted)" }
                }
            }
        }
    }
}
