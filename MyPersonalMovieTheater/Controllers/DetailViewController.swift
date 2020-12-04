//
//  DetailViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/04.
//

import UIKit

class DetailViewController: UIViewController {

    var gernes: [String] = ["Action","Comedy","Romance","Horror"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    
    }
    

    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gernes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as? GenresCollectionViewCell else { return UICollectionViewCell() }
        cell.gernes.text = gernes[indexPath.row]
        return cell
    }
    
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 48)
    }
}
