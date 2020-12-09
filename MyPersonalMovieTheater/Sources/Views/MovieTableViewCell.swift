//
//  MovieTableViewCell.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import UIKit
import Cosmos

class MovieTableViewCell: UITableViewCell {
    let baseUrl = "https://image.tmdb.org/t/p/w185/"
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieTotalRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRatinginStars: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(_ item : Movie){
        movieTitle.text = item.title
        movieTotalRating.text = "\(item.rating)"
        movieRatinginStars.rating = item.rating / 2
        let url = URL(string: "\(baseUrl)\(item.posterPath)")
        movieImg.kf.setImage(with: url)
        movieReleaseDate.text = "Release Date: \(item.releaseDate)"
        
    }
}
/// # Review 4-2 [cell에 내용 채워 넣기] [Fixed]
 /// func configure(_ item: Movie) 와 같은 함수를 만들어서
 /// 여기서 각 View에 내용들을 채워넣으면 깔끔하겠죠?
