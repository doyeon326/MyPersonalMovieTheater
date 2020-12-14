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

    var movieViewModel = MovieViewModel.shared 

    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingInStar: CosmosView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNetwork()
        settingUpUI()
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
    //doesnt need item :) because it will play with YTPlayer.
        guard let key = movieViewModel.video.first?.key else {
            return
        }
        let movieKey = "https://www.youtube.com/watch?v=\(key)"
        let url = URL(string: movieKey)!
        let item = AVPlayerItem(url: url)
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.modalPresentationStyle = .fullScreen
        
     //   vc.player.replaceCurrentItem(with: item)
        present(vc, animated: false, completion: nil)
    }
    
    func prepareNetwork(){
        MovieViewModel.shared.genres = []
        MovieViewModel.shared.fetchMovieDetail{
            self.genresCollectionView.reloadData()
        }
        MovieViewModel.shared.fetchVideo{}
        MovieViewModel.shared.fetchSimilarMovies{}
        
    }
    func settingUpUI(){
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        print(movieViewModel.movies.count)
        movieTitle.text = movieViewModel.movies[movieViewModel.fetchMovieIndex()].title
        movieOverview.text = movieViewModel.movies[movieViewModel.fetchMovieIndex()].overview

        let imagePath = movieViewModel.movies[movieViewModel.fetchMovieIndex()].posterPath
        let url = URL(image: imagePath)
        movieImg.kf.setImage(with: url)
        rating.text = "\(movieViewModel.movies[movieViewModel.fetchMovieIndex()].rating)"
        ratingInStar.rating = movieViewModel.movies[movieViewModel.fetchMovieIndex()].rating / 2
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as? GenresCollectionViewCell else { return UICollectionViewCell() }
        cell.gernes.text = movieViewModel.genres[indexPath.row].name
        return cell
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 48)
    }
}

