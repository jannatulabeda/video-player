//
//  APIRequest.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

class APIRequest: NSObject {
    
    static let shared: APIRequest = APIRequest()
    private let apiService = APIService()
    

    func getPlayList(completionHandler: @escaping() -> ()) {

        let _url = "https://quipper.github.io/native-technical-exam/playlist.json"
        completionHandler()
        apiService.request(urlString: _url, parameters: nil) { (data, URLResponse, error) in
        }
    }
}
