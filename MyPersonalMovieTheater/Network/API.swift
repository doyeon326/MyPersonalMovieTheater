//
//  File.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import Foundation

class API {
    
    static let apiKey = "7e9668bd55961d140e7ec7cbf4f25cf4"
    
    static func loadMovies(_ page: Int, completion: @escaping ([Movie]) -> Void) {
        let session = URLSession(configuration: .default)
    
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/now_playing?")!
        //https://api.themoviedb.org/3/movie/now_playing?api_key=7e9668bd55961d140e7ec7cbf4f25cf4&language=en-US&page=2
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        let languageQuery = URLQueryItem(name: "language", value: "en-US")
        let pageQuery = URLQueryItem(name: "page", value: "\(page)")
        urlComponents.queryItems?.append(apiQuery)
        urlComponents.queryItems?.append(languageQuery)
        urlComponents.queryItems?.append(pageQuery)
        
        let requestURL = urlComponents.url!
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                completion([])
                return
            }
            guard let resultData = data else {
                completion([])
                return
            }
            let movies = API.decodeMovie(resultData)
            print("##success!")
            completion(movies)
        }
        dataTask.resume()
    }
    
    static func decodeMovie(_ data: Data) -> [Movie] {
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIResults.self, from: data)
            let movie = response.movies
            return movie
        } catch let error {
            print("##decodingError: \(error.localizedDescription)")
            return []
        }
        
    }
}
