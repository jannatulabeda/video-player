//
//  APIUrl.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

struct APIUrl {
    private struct Bases {
        static let Production = "https://quipper.github.io"
        static let Dev = "https://quipper.github.io"
    }
    
    private struct Route {
        static let TechnicalExam = "/native-technical-exam"
    }
    
    #if DEBUG
    private static let BaseURL = Bases.Dev
    #else
    private static let BaseURL = Bases.Production
    #endif

    // Playlist
    static var GetPlayList: String {
        return BaseURL + Route.TechnicalExam + "/playlist.json"
    }
}
