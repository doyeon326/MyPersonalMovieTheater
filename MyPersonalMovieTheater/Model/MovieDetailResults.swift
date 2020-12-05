//
//  MovieDetail.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/05.
//

import Foundation

struct MovieDetailResults: Decodable {
    let genres : [Genres]
}

struct Genres: Decodable {
    let id: Int
    let name: String
}
