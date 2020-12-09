//
//  File.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import Foundation
/// # Review 8 [API 작업에 대한 분리]
/// 이 부분은 여기서 글로는 한계가 있을 것 같아서 나중에 같이 보는걸로 해요.
class API {
    /// # Review 7 [반복되는 상수 정의]
    /// apiKey같은 민감한 정보는 가급적 코드에 넣으면 좋지 않습니다.
    /// 코드에 남아있는건 둘째 치더라도, GitHub에 그대로 올라가기 때문이에요.
    /// 서버나 파이어베이스 등 코드 상에 직접적인 노출을 피해 가져오면 가장 좋지만,
    /// 일단 지금 간단하게 할 수 있는 최소한의 방법은 Resources디렉토리에 apiKey 파일을 별도로 만들고, 이를 .gitignore에서 파일을 추가해버리면 git에는 올라가지 않아서 당장의 문제는 해결할 수 있습니다.
    /// 물론 중요한 돈을 내는 api는 아니라 상관은 없겠지만 이 작업은 항상 첫 커밋 전에 해줘야해요.
    /// 커밋 이력에도 남아서 GitHub에서는 볼라면 볼 수 있게 됩니다.
    static let apiKey = "7e9668bd55961d140e7ec7cbf4f25cf4"
    //https://api.themoviedb.org/3/movie/33432/similar?api_key=7e9668bd55961d140e7ec7cbf4f25cf4&language=en-US&page=1
    static func loadMovies(_ page: Int, completion: @escaping ([Movie]) -> Void) {
        let session = URLSession(configuration: .default)
        
        var str = ""
        if MovieViewModel.shared.isTodaysMovie {
            str = "https://api.themoviedb.org/3/movie/now_playing?"
        }
        else{
            str = "https://api.themoviedb.org/3/movie/\(MovieViewModel.shared.movies[MovieViewModel.shared.selectedMovieIndex].id)/similar?"
            print("string: \(str), value: \(MovieViewModel.shared.isTodaysMovie),movieId: \(MovieViewModel.shared.movies[MovieViewModel.shared.selectedMovieIndex].id)")
        }
      
        var urlComponents = URLComponents(string: str)!
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
            print("##MovieLoad success!")
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
            print("##MovieLoad decodingError: \(error.localizedDescription)")
            return []
        }
        
    }
    
    static func loadMovieDetail(_ movieId: Int, completion: @escaping ([Genres]) -> Void) {
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieId)?")!
        //https://api.themoviedb.org/3/movie/62345?api_key=7e9668bd55961d140e7ec7cbf4f25cf4&language=en-US
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        let languageQuery = URLQueryItem(name: "language", value: "en-US")
        urlComponents.queryItems?.append(apiQuery)
        urlComponents.queryItems?.append(languageQuery)
        
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
            let movieDetail = API.decodeMovieDetail(resultData)
            print("##MovieDetail success!")
            completion(movieDetail)
        }
        dataTask.resume()
    }
    
    
    static func decodeMovieDetail(_ data: Data) -> [Genres] {
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(MovieDetailResults.self, from: data)
            let genres = response.genres
            return genres
        } catch let error {
            print("##MovieDetail decodingError: \(error.localizedDescription)")
            return []
        }
        
    }
    static func loadVideo(_ movieId: Int, completion: @escaping ([VideoKey]) -> Void) {
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?")!
        //https://api.themoviedb.org/3/movie/590706/videos?api_key=7e9668bd55961d140e7ec7cbf4f25cf4&language=en-US
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        let languageQuery = URLQueryItem(name: "language", value: "en-US")
        urlComponents.queryItems?.append(apiQuery)
        urlComponents.queryItems?.append(languageQuery)
        
        let requestURL = urlComponents.url!
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                return
            }
            guard let resultData = data else {
                return
            }
//            let str = String(decoding: resultData, as: UTF8.self)
//            print("#######\(str.description)")
            let movieVideo = API.decodeVideo(resultData)
            print("##LoadVideo success!")
            completion(movieVideo)
        }
        dataTask.resume()
    }
    
    static func decodeVideo (_ data: Data) -> [VideoKey] {
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(VideoResults.self, from: data)
            let videoKey = response.results
            
            return videoKey
        } catch let error {
            print("##LoadVideo decodingError: \(error.localizedDescription)")
            return []
        }
    }
}
