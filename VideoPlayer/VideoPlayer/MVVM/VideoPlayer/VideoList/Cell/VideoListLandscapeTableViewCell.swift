//
//  VideoListLandscapeTableViewCell.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/07/02.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

class VideoListLandscapeTableViewCell: UITableViewCell {

    // MARK : - @IBOutlet
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPresenter: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    
    // MARK : - Variables
    var videoURL: String?
    var pressedVideoPlayer: (() -> Void)?
    
    // MARK : - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Setup data
    func setupData(videoCellVM: VideoCellVM) {
        self.imageViewThumbnail.loadUrl(urlStr: videoCellVM.videoThumbnail)
        self.labelTitle.text = videoCellVM.videoTitle
        self.labelDescription.text = videoCellVM.videoDescription
        self.labelPresenter.text = videoCellVM.videoPresenter
        self.labelDuration.text = String(videoCellVM.videoDuration)
        self.videoURL = videoCellVM.videoURL
    }
    
    // Player button pressed
    @IBAction func videoPlayerButtonPressed(_ sender: Any) {
        if let _pressedVideoPlayer = pressedVideoPlayer {
            _pressedVideoPlayer()
        }
    }
}
