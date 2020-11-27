//
//  VideoResults.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import Foundation

struct VideoResults: Decodable {
    let details: [VideoKey]
    private enum Codingkeys: String, CodingKey {
        case details = "results"
    }
}

struct VideoKey: Decodable {
    let key: String
}
