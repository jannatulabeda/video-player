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
    var videoURL: String?
    
    init(videoPlayer: VideoPlayer) {
        super.init()
        videoThumbnail = videoPlayer.thumbnail_url
        videoTitle = videoPlayer.title
        videoDescription = videoPlayer.description
        videoPresenter = videoPlayer.presenter_name
        
        let (hours,mins,sec) = self.miliSecondsToHoursMinutesSeconds(miliSeconds: videoPlayer.video_duration)
        if hours > 0 {
            videoDuration = "\(hours):"
        }
        videoDuration += "\(mins):\(sec)"
        videoURL = videoPlayer.video_url
    }
    
    // Convert from miliseconds to seconds, mins, hours
    func miliSecondsToHoursMinutesSeconds (miliSeconds : Int) -> (Int, Int, Int) {
        let seconds = miliSeconds / 1000
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
