//
//  Movie.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import Foundation
//MARK: what is the difference between Codable VS Decodable?
//codable = enclodable + decodable

struct Movie: Decodable {
    let id: Int
    let posterPath: String
    var videoPath: String?
    let backdrop: String
    let title: String
    var releaseDate: String
    var rating: Double
    let overview: String
    
    /// # Review 3 [가독성]
    /// 길게 옆으로 늘여서 치다보면 가독성이 떨어지는 경우가 많아요. 아래의 경우에는 아무래도 각 속성마다 엔터를 쳐서 밑으로 내려주면 가독성이 좋아질 것 같습니다.
    /// 또는 세로로 코드를 작성하고 각각의 속성에 case를 붙이는게 더 깔끔해보일 수도 있을 것 같네요
    private enum CodingKeys: String, CodingKey {
        case id, posterPath = "poster_path", videoPath, backdrop = "backdrop_path", title, releaseDate = "release_date", rating = "vote_average", overview
    }
    
    
    
}
