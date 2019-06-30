//
//  VideoCellVM.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

class VideoCellVM: NSObject {
    var videoThumbnail: String = ""
    var videoTitle: String = ""
    var videoDescription: String = ""
    var videoPresenter: String = ""
    var videoDuration: String = ""
    
    init(videoPlayer: VideoPlayer) {
        super.init()
        videoThumbnail = videoPlayer.thumbnail_url
        videoTitle = videoPlayer.title
        videoDescription = videoPlayer.description
        videoPresenter = videoPlayer.presenter_name
        
        let (hours,mins,sec) = self.secondsToHoursMinutesSeconds(seconds: videoPlayer.video_duration)
        videoDuration = "\(hours):\(mins):\(sec)"
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
