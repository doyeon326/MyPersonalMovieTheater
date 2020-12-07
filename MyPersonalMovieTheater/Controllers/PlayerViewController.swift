//
//  PlayerViewController.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/12/06.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var controlView: UIView!

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeRight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerView.delegate = self
        guard let key = MovieViewModel.shared.video.first?.key else { return }
        print(key)

        playerView.load(withVideoId: key, playerVars: ["playsinline": "1"])
        
       
    }
    override func viewWillAppear(_ animated: Bool) { //바로 재생 되게끔 설정
        super.viewWillAppear(animated)
    
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
