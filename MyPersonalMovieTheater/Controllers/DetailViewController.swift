//
//  DetailViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/04.
//

import UIKit
import Kingfisher
import Cosmos
import AVFoundation

class DetailViewController: UIViewController {
    let baseUrl = "https://image.tmdb.org/t/p/w300/"
    var movieViewModel = MovieViewModel.shared //need to be stored in sperate Class
    
    //var gernes: [String] = ["Action","Comedy","Romance","Horror"]

 
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingInStar: CosmosView!
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
        MovieViewModel.shared.fetchVideo{
            print("##completed video")
            print("\(self.movieViewModel.video.first?.key)")
        }
        MovieViewModel.shared.fetchSimilarMovies {
            print("##completed getting similar Movies")
        }
        
        print(movieViewModel.movies.count)
        movieTitle.text = movieViewModel.movies[movieViewModel.fetchMovieIndex()].title
        movieOverview.text = movieViewModel.movies[movieViewModel.fetchMovieIndex()].overview
        let url = URL(string:"\(baseUrl)\( movieViewModel.movies[movieViewModel.fetchMovieIndex()].posterPath)")
        movieImg.kf.setImage(with: url)
        rating.text = "\(movieViewModel.movies[movieViewModel.fetchMovieIndex()].rating)"
        ratingInStar.rating = movieViewModel.movies[movieViewModel.fetchMovieIndex()].rating / 2
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
    
        guard let key = movieViewModel.video.first?.key else {
            return
        }
        let movieKey = "https://www.youtube.com/watch?v=\(key)"
        print("@@@movie key: \(movieKey)")
        let url = URL(string: movieKey)!
        let item = AVPlayerItem(url: url)
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.modalPresentationStyle = .fullScreen
        
     //   vc.player.replaceCurrentItem(with: item)
        present(vc, animated: false, completion: nil)
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
        return CGSize(width: 90, height: 48)
    }
}
