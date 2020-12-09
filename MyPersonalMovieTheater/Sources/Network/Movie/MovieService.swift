//
//  MovieService.swift
//  MyPersonalMovieTheater
//
//  Created by stat on 2020/12/09.
//

import Foundation

class MovieService: Networkable {
  
  static func loadMovies(_ page: Int, completion: @escaping ([Movie]) -> Void) {
    requestAPI(MovieAPI.movies(page: page)) { data in
      let decodedData = self.decode(APIResults.self, data: data)
      completion(decodedData?.movies ?? [])
    }
  }
  
  static func loadMovieDetail(_ movieId: Int, completion: @escaping ([Genres]) -> Void) {
    requestAPI(MovieAPI.movieDetail(movieId: movieId)) { (data) in
      let decodedData = self.decode(MovieDetailResults.self, data: data)
      completion(decodedData?.genres ?? [])
    }
  }
  
  static func loadVideo(_ movieId: Int, completion: @escaping ([VideoKey]) -> Void) {
    requestAPI(MovieAPI.video(movieId: movieId)) { (data) in
      let decodedData = self.decode(VideoResults.self, data: data)
      completion(decodedData?.results ?? [])
    }
  }
  
}
