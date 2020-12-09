//
//  URLExtension.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/09.
//

import Foundation
/// # Review 6-2 [반복되는 상수 정의] [Fixed]
/// 이 baseUrl이 반복적으로 사용되는 곳은 결국 URL객체를 만들기 위해서 사용되는 것이기 때문에,
/// URL 구조체 안에서 따로 선언해주는 것도 나쁘지 않은 방법일 것 같아요.
/// 그리고 지금의 경우에는 새로운 URL 초기화 메소드를 생성해주고 여기에 파라미터로 url의 뒤에 오는 주소를 넣어주는 식으로 만들어 봤습니다.
/// Review 6-3으로!
/// 아 그리고 아래 URL은 별도로 URLExtension.swift와 같이 파일을 만들어서 넣어두시면 관리하기 편할거에요.
/// 위치는 Util/Extensions 정도면 괜찮을 것 같아요.
extension URL {
    init?(image path: String) {
        let baseUrl = "https://image.tmdb.org/t/p/w300/"
        self.init(string: "\(baseUrl)\(path)")
    }
}
