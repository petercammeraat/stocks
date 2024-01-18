//
//  IndexView.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import HTMLKit
import HTMLKitComponents

struct IndexView: View {
    var body: Content {
        BaseView {
            Main {
                SearchForm()
            }
        }
    }
}
