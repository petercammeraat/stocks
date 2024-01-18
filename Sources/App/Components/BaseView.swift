//
//  BaseView.swift
//  Stocks
//  BSD 3-Clause License
//  Copyright 2024 Peter Cammeraat
//

import HTMLKit
import HTMLKitComponents

struct BaseView: View {
    var content: [BodyElement]

    init(@ContentBuilder<BodyElement> content: () -> [BodyElement]) {
        self.content = content()
    }

    var body: Content {
        Document(.html5)
        Html {
            Head {
                Meta().charset(.utf8)
                Meta().name(.viewport).content("width=device-width, initial-scale=1.0")
                Title { "Stocks" }
                Link().relationship(.stylesheet).reference("/styles.css")
                Link().relationship(.stylesheet).reference("/htmlkit/all.css")
            }
            Body {
                content
            }
        }
    }
}
