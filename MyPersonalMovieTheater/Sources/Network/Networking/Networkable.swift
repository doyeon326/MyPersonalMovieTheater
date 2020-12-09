//
//  Networkable.swift
//  MyPersonalMovieTheater
//
//  Created by stat on 2020/12/09.
//

import Foundation

protocol Networkable {
  static func requestAPI(
    _ api: EndPointType,
    completion: @escaping ((Data) -> Void))
  
  static func decode<T: Codable>(_ type: T.Type, data: Data) -> T?
}

extension Networkable {
  static func requestAPI(
    _ api: EndPointType,
    completion: @escaping ((Data) -> Void)) {
    guard let targetURL = api.url else { return }
    
    print("👉Request : \(targetURL)")
    
    URLSession(configuration: .default)
      .dataTask(with: targetURL) { (data, response, error) in
        guard let data = data else {
          //Do error handling in here
          return
        }
        completion(data)
      }.resume()
  }
  
  static func decode<T: Codable>(_ type: T.Type, data: Data) -> T? {
    do{
      let response = try JSONDecoder().decode(type, from: data)
      return response
    } catch let error {
      print("##decodingError: \(error.localizedDescription)")
    }
    return nil
  }
}
