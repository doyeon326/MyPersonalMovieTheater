//
//  ViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import UIKit
import Kingfisher
import Cosmos

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
            movieViewModel.updateMovieIndex(indexPath.row)
        } /// # Review 5 [가독성, 일관성] [Fixed]
        /// 위에서 뷰모델을 변수로 놓으셨기 때문에 여기서도 뷰모델을 변수로 사용하면 더 일관된 코드가 될 것 같네요. 물론 싱글톤이기에 동작은 똑같지만요.
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// # Review 4-1 [cell에 내용 채워 넣기] [Fixed]
               /// 잘하셨어요
               /// 근데 조금 더 많이 사용하는 코드의 패턴을 알려드릴게요.
               /// cell에 함수를 하나 만들고 파라미터로 데이터를 넘겨주면 해당 함수 안에서 cell의 UI를 채워주는 함수를 만들어보면 View Controller가 한 결 더 가벼워 질 것 같아요.
               /// 파라미터에는 movieViewModel.movies[indexPath.row]만 넘겨주면 돼요.
               /// Review 4-2로 이동해보세요.
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
 
        cell.configure(movieViewModel.movies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    
}

