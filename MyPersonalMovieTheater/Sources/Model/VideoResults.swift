//
//  VideoResults.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import Foundation

struct VideoResults: Codable {
    let results: [VideoKey]
}

struct VideoKey: Codable {
    let key: String
    let id: String
}
