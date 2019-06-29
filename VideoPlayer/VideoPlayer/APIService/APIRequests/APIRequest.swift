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
    

    func getPlayList(completionHandler: @escaping([VideoPlayer]?) -> ()) {

        let _url = APIUrl.GetPlayList
        apiService.request(urlString: _url, parameters: nil) { (data, URLResponse, error) in
            if let _data = data {
                do {
                    let _playList = try JSONDecoder().decode([VideoPlayer].self, from: _data)
                    completionHandler(_playList)
                } catch let parsingError {
                    Helper.shared.log(object: parsingError)
                    completionHandler(nil)
                }
            }
        }
    }
}
