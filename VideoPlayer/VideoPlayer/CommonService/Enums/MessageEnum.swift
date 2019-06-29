//
//  MessageEnum.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

enum Message: String {
    
    // MARK: - Log messages
    case LOG_URL = "log_url"
    case LOG_PARAMETERS = "log_parameters"
    case LOG_RESPONSE = "log_response"
    
    // Loacalized
    var localized: String {
        return self.rawValue.localized(tableName: "Message")
    }
}
