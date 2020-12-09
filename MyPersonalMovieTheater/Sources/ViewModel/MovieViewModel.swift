//
//  MovieViewModel.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/28.
//

import Foundation

class MovieViewModel {
    
    static let shared = MovieViewModel()
    
    var isTodaysMovie: Bool = true
    var movies: [Movie]
    var similarMovies: [Movie]
    var video : [VideoKey]
    var selectedMovieIndex: Int = 0
    var genres: [Genres]
    
    init() {
        self.movies = [Movie]()
        self.genres = [Genres]()
        self.video = [VideoKey]()
        self.similarMovies = [Movie]()
    }
    
    func fetchMovies(completionHandler: @escaping () -> Void) {
        self.isTodaysMovie = true
      
        MovieService.loadMovies(1) { (movies) in
            DispatchQueue.main.async {
                self.movies = movies
               // self.movies.append(contentsOf: movies)
                completionHandler()
            }
        }
      
//        API.loadMovies(1) { movies in
//            DispatchQueue.main.async {
//                self.movies = movies
//               // self.movies.append(contentsOf: movies)
//                completionHandler()
//            }
//        }
    }
    
    func fetchMovieDetail(completionHandler: @escaping () -> Void) {
       
        API.loadMovieDetail(movies[selectedMovieIndex].id) { genre in
            DispatchQueue.main.async {
//                self.movie = movies
                //self.genres.append(contentsOf: genre)
                self.genres = genre
               // print(genre.first?.name)
                completionHandler()
            }
        }
    }
    func fetchVideo(completionHandler: @escaping () -> Void) {
        API.loadVideo(movies[selectedMovieIndex].id) {
            video in
            DispatchQueue.main.async {
                self.video = video
                print(video.first?.key)
                completionHandler()
            }
        }
    }
    func fetchSimilarMovies(completionHandler: @escaping ()  -> Void ) {
        self.isTodaysMovie = false
        API.loadMovies(1) { similarMovies in
         //   print("--->\(similarMovies.count) ")
            self.similarMovies = similarMovies //하고있었삼~ 
            print("##completed getting similar movies!")
            print(self.similarMovies.first?.title)
        }
    }
    
    func updateMovieIndex(_ index: Int) -> Void {
        self.selectedMovieIndex = index
    }
    func fetchMovieIndex() -> Int {
        return self.selectedMovieIndex
    }
}


