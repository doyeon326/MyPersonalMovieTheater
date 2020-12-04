//
//  MovieViewModel.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/28.
//

import Foundation

class MovieViewModel {
    var movies: [Movie]

    init() {
        self.movies = [Movie]()
    }
    
    func fetchMovies(completionHandler: @escaping () -> Void) {
        API.loadMovies(1) { movies in
            DispatchQueue.main.async {
//                self.movie = movies
                self.movies.append(contentsOf: movies)
                completionHandler()
            }
        }
    }
}
