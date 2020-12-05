//
//  DetailViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/04.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    let baseUrl = "https://image.tmdb.org/t/p/w185/"
    var movieViewModel = MovieViewModel.shared //need to be stored in sperate Class
    
    //var gernes: [String] = ["Action","Comedy","Romance","Horror"]

    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        //한발짝 느림..
        MovieViewModel.shared.genres = []
        MovieViewModel.shared.fetchMovieDetail{
            self.genresCollectionView.reloadData()
        }
        
        print(movieViewModel.movies.count)
        movieTitle.text = movieViewModel.movies[movieViewModel.fetchMovieIndex()].title
        movieOverview.text = movieViewModel.movies[movieViewModel.fetchMovieIndex()].overview
        let url = URL(string:"\(baseUrl)\( movieViewModel.movies[movieViewModel.fetchMovieIndex()].posterPath)")
        movieImg.kf.setImage(with: url)
        
        
    }
    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //gernes.count
        movieViewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as? GenresCollectionViewCell else { return UICollectionViewCell() }
        cell.gernes.text = movieViewModel.genres[indexPath.row].name
       // cell.gernes.text = gernes[indexPath.row]
        return cell
    }
    
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 48)
    }
}
