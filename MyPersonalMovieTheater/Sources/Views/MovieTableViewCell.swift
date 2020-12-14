//
//  MovieTableViewCell.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import UIKit
import Cosmos
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
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
        let url = URL(image: item.posterPath)
        movieImg.kf.setImage(with: url)
        movieReleaseDate.text = "Release Date: \(item.releaseDate)"
        
    }
}
