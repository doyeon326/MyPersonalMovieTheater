//
//  VideoResults.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import Foundation

struct VideoResults: Decodable {
    let results: [VideoKey]
}

struct VideoKey: Decodable {
    let key: String
    let id: String
}
