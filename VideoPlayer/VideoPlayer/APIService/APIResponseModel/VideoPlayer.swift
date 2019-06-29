//
//  VideoPlayer.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

struct VideoPlayer: Codable {
    var title: String
    var presenter_name: String
    var description: String
    var thumbnail_url: String
    var video_url: String
    var video_duration: Int32
}
