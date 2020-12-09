//
//  MovieAPI.swift
//  MyPersonalMovieTheater
//
//  Created by stat on 2020/12/09.
//
import Foundation

enum MovieAPI {
  case movies(page: Int)
  case movieDetail(movieId: Int)
  case video(movieId: Int)
}

extension MovieAPI: EndPointType {
  static let apiKey = "7e9668bd55961d140e7ec7cbf4f25cf4"

  var baseURL: String {
    return "https://api.themoviedb.org"
  }

  var path: String {
    switch self {
    case .movies:
      var str = ""
      if MovieViewModel.shared.isTodaysMovie {
        str = "/3/movie/now_playing?"
      } else {
        let id = MovieViewModel.shared.movies[MovieViewModel.shared.selectedMovieIndex].id
        str = "/3/movie/\(id)/similar?"
      }
      return str
    case .movieDetail(let movieId):
      return "/3/movie/\(movieId)?"
    case .video(let movieId):
      return "/3/movie/\(movieId)/videos?"
    }
  }

  var queryItems: [URLQueryItem] {
    var queryItems = [
      URLQueryItem(name: "api_key", value: MovieAPI.apiKey),
      URLQueryItem(name: "language", value: "en-US")
    ]
    switch self {
    case .movies(let page):
      queryItems.append(URLQueryItem(name: "page", value: String(page)))
      return queryItems
    default:
      return queryItems
    }
  }

  var url: URL? {
    var urlComponents = URLComponents(string: baseURL + path)
    urlComponents?.queryItems?.append(contentsOf: queryItems)
    return urlComponents?.url
  }
}
