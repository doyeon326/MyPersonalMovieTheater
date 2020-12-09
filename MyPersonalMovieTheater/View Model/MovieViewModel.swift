//
//  MovieViewModel.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/28.
//

import Foundation

class MovieViewModel {
    /// # Review 1 [ViewModel 사용]
    /// View Model을 싱글톤 패턴을 사용해서 만드셨네요
    /// 일반적으로 ViewModel은 하나의 ViewController에 1:1로 매칭되어 만들어지는 편입니다. (물론  TableViewCell, CollectionViewCell이 복잡해지는 경우에는 CellViewModel이 만들어지기도 합니다.)
    /// 이론적으로는 ViewModel이 여러 View에서 사용가능 하도록 재사용 가능하도록 설계해야하지만 현실적으로 그러는 경우는 많이 못 본 것 같아요.
    /// 그래서 결론은 뷰모델은 싱글턴으로 만드는 것 보다 각각의 뷰 컨트롤러 안에서 생성해서 사용하는 편이 나아 보입니다.
    /// 뷰모델을 MovieViewController, DetailViewController, RelatedMovieViewController와 연결되는 클래스로 각각 생성해서 필요한 데이터와 필요한 함수만 넣어서 사용해보시는걸 권유드립니다.
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
        API.loadMovies(1) { movies in
            DispatchQueue.main.async {
                self.movies = movies
               // self.movies.append(contentsOf: movies)
                completionHandler()
            }
        }
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


