//
//  APIEnum.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

enum APIMethodType: String {
    
    case GET = "GET"
    case POST = "POST"
    
    // String value
    var value: String {
        return self.rawValue
    }
}
