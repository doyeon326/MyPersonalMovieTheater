//
//  RelatedMovieViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/05.
//

import UIKit
import Kingfisher

/// # Review 2 [가독성]
/// 뒤에 UIViewController클래스 상속하는 부분이 과도하게 내려가서 가독성이 안좋아요. (아마 아래의 경우엔 실수겠죠??ㅎㅎ)
/// 가급적 일관되게 작성해주는 편이 좋은데, 코드 들여쓰기나, 라인 맞추기는 항상 신경써 주시는게 가독성에 도움이 됩니다👍
class RelatedMovieViewController:
    
    UIViewController {
    let baseUrl = "https://image.tmdb.org/t/p/w185/"
    var movieViewModel = MovieViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("this is getSimilarMovies: \(movieViewModel.similarMovies.first?.title)")
    }
}

extension RelatedMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModel.similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedMovies", for: indexPath) as? RelatedMovieCell else { return UICollectionViewCell() }
        let url = URL(string: "\(baseUrl)\(movieViewModel.similarMovies[indexPath.row].posterPath)") //ERROR: Index out of range: file Swift/ContiguousArrayBuffer.swift
        cell.RelatedMovieImg.kf.setImage(with: url)
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
