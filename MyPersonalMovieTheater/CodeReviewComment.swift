//

//  CodeReviewComments.swift

//  MyPersonalMovieTheater

//

//  Created by stat on 2020/12/09.

//

/*
 
 ViewModel을 싱클톤으로 작성한 것은 문제가 있어보임.
 
 1. viewModel이 메모리에서 해제되지 않게됨, 일반적으로 싱글톤으로 작성하지 않음
 
 2. constructor injection에 대해서 알아보고 적용해보기
 
 ViewDidLoad에서 어떤 동작을 바로 정의하지마세요.
 
 1. 뷰컨트롤러 라이프사이클 메서드 내에서 수행되는 동작은 따로 메서드를 정의하여 관리합니다.
 
 2. ex
 
 -------------------------------------------
 
 class ViewController: UIViewController {
 
 override func viewDidLoad() {
 
 super.viewDidLoad()
 
 fetchDatas()
 
 setupUI()
 
 }
 
 }
 
 func setupUI() {
 
 //some code here
 
 }
 
 func fetchDatas() {
 
 //some code here
 
 }
 
 -------------------------------------------
 
 ViewController - ViewModel을 같은 폴더에서 관리하세요. - Scenes, Modules, Views 보통 이런식으로 네이밍합니다.
 
 1. ex
 
 Scene
 
 ㄴ Movie
 
  ㄴ MovieViewController
 
  ㄴ MovieViewModel
 
 ㄴ Detail
 
  ㄴ DetailViewController
 
  ㄴ DetailViewModel
 
 ...
 
 코드컨벤션 미준수
 
 1. https://github.com/raywenderlich/objective-c-style-guide
 
 2. SwiftLint 라이브러리를 사용하면 코드 컨벤션을 강제할 수 있습니다.
 
 */
