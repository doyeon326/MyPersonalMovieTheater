//
//  MovieDetail.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/05.
//

import Foundation

struct MovieDetailResults: Codable {
    let genres : [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
}
