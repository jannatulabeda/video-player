//
//  UIExtensionImageView.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/30.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {

    func loadUrl(urlStr: String) {
        Alamofire.request(urlStr).responseImage { response in
            if let _image = response.result.value {
                DispatchQueue.main.async {
                    self.image = _image
                }
            }
        }
    }
}
