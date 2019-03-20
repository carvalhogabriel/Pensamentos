//
//  Quote.swift
//  Pensamentos
//
//  Created by Gabriel Carvalho Guerrero on 19/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import Foundation

struct Quote: Codable {
    
    let quote: String
    let author: String
    let image: String
    
    var quoteFormatted: String {
        return "❝" + quote + "❞"
    }
    
    var authorFormatted: String {
        return "- " + author + " -"
    }
}
