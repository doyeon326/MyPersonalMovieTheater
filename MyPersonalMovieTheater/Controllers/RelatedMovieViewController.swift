//
//  RelatedMovieViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/05.
//

import UIKit

class RelatedMovieViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension RelatedMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedMovies", for: indexPath) as? RelatedMovieCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

extension RelatedMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 600)
    }
}

class RelatedMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var RelatedMovieImg: UIImageView!
}
