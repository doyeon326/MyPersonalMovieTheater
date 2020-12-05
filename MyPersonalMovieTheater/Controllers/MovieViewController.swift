//
//  ViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {

    var movieViewModel = MovieViewModel.shared
    let baseUrl = "https://image.tmdb.org/t/p/w185/"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        loadMovies()
        
        movieViewModel.fetchMovies {
            self.tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            MovieViewModel.shared.updateMovieIndex(indexPath.row)
        }
 
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.movieTitle.text = movieViewModel.movies[indexPath.row].title
        cell.movieTotalRating.text = "\(movieViewModel.movies[indexPath.row].rating)"
        let url = URL(string: "\(baseUrl)\(movieViewModel.movies[indexPath.row].posterPath)")
        cell.movieImg.kf.setImage(with: url)
        cell.movieRatinginStars.rating = movieViewModel.movies[indexPath.row].rating / 2
        cell.movieReleaseDate.text = "Release Date: \(movieViewModel.movies[indexPath.row].releaseDate)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    
}

