//
//  ErrorMessage.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

enum ErrorMessage: String {
    
    // MARK: - API ERROR
    case API_ERROR_URL_ERROR = "api_error_url_error"
    case API_ERROR_JSON_SERIALIZATION_ERROR = "api_error_json_serialize_error"
    case API_ERROR = "api_error"
    case API_ERROR_RATE_LIMIT = "api_error_rate_limit"
    
    // Loacalized
    var localized: String {
        return self.rawValue.localized(tableName: "ErrorMessage")
    }
}
