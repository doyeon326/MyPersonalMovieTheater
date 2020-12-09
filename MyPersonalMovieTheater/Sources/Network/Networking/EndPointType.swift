//
//  EndPointType.swift
//  MyPersonalMovieTheater
//
//  Created by stat on 2020/12/09.
//

import Foundation

protocol EndPointType {
  var baseURL: String { get }
  var path: String { get }
  var url: URL? { get }
}
