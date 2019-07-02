//
//  APIService.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

import UIKit

class APIService: NSObject {
    
    func request(urlString: String,
                 methodType: String? = APIMethodType.GET.value,
                 parameters: [String: Any]?,
                 completionHandler: @escaping(Data?, URLResponse?, Error?) -> ()) {
        
        guard let _url = URL(string: urlString) else {
            Helper.shared.log(object: ErrorMessage.API_ERROR_URL_ERROR.localized)
            return
        }
        
        var _request = URLRequest(url: _url)
        _request.httpMethod = methodType
        Helper.shared.log(object: Message.LOG_URL.localized + urlString)
        
        if let _parameters = parameters {
            let _parametersString: String = _parameters.enumerated().reduce("?") { (input, tuple) -> String in
                switch tuple.element.value {
                case let int as Int: return input + tuple.element.key + "=" + String(int) + (_parameters.count - 1 > tuple.offset ? "&" : "")
                case let string as String: return input + tuple.element.key + "=" + string + (_parameters.count - 1 > tuple.offset ? "&" : "")
                default: return input
                }
            }
            _request.httpBody = _parametersString.data(using: String.Encoding.utf8)
            Helper.shared.log(object: Message.LOG_PARAMETERS.localized + "\(_parameters)")
        }
        
        let _task = URLSession.shared.dataTask(with: _request) { data, response, error in
            if let _data = data {
                do {
                    let _json = try JSONSerialization.jsonObject(with: _data, options: .allowFragments)
                    Helper.shared.log(object: Message.LOG_RESPONSE.localized + "\(_json)")
                    completionHandler(data, response, nil)
                } catch {
                    Helper.shared.log(object: ErrorMessage.API_ERROR_JSON_SERIALIZATION_ERROR.localized)
                    completionHandler(nil, response, nil)
                }
            } else {
                Helper.shared.log(object: error ?? ErrorMessage.API_ERROR.localized)
                completionHandler(nil, response, error)
            }
        }
        _task.resume()
    }
}

