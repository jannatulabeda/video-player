//
//  VideoListTableViewCell.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit
import AlamofireImage

class VideoListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPresenter: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    var videoURL: String?
    var pressedVideoPlayer: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(videoCellVM: VideoCellVM) {
        self.imageViewThumbnail.loadUrl(urlStr: videoCellVM.videoThumbnail)
        self.labelTitle.text = videoCellVM.videoTitle
        self.labelDescription.text = videoCellVM.videoDescription
        self.labelPresenter.text = videoCellVM.videoPresenter
        self.labelDuration.text = String(videoCellVM.videoDuration)
        self.videoURL = videoCellVM.videoURL
    }
    
    @IBAction func videoPlayerButtonPressed(_ sender: Any) {
        if let _pressedVideoPlayer = pressedVideoPlayer {
            _pressedVideoPlayer()
        }
    }
}
