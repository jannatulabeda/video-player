//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {
    var videoURL: String?
    var closeVideoPlayer: (() -> Void)?
    var videoLauncher: VideoLauncher?
    
    // MARK : - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        videoLauncher = VideoLauncher()
        videoLauncher!.videoLink = videoURL!
        videoLauncher!.showVideoPlayer()
        videoLauncher!.closeVideoPlayer = {
            self.closeVideoPlayer!()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Helper.shared.lockOrientation(.landscape)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoLauncher = nil
        Helper.shared.lockOrientation(.all)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}
