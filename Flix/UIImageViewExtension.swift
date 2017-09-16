//
//  UIImageViewExtension.swift
//  Flix
//
//  Created by Varun on 9/16/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    
    func setLowResAndHighResImage(lowResImageUrlString: String, highResImageUrlString: String) {
        if let lowResImageUrl = URL(string: lowResImageUrlString){
            let lowResImageUrlRequest = URLRequest(url: lowResImageUrl)
            
            setImageWith(lowResImageUrlRequest, placeholderImage: nil, success: { (urlRequest, response, image) in
                
                DispatchQueue.main.async {
                    self.image = image
                    let highResImageUrl = URL(string: highResImageUrlString)
                    self.setImageWith(highResImageUrl!)
                }
                
            }, failure: { (urlRequest, resposne, errror) in
                //
            })
        }
    }
    
    func setImageWithAnimation(imageUrlString: String) {
        if let imageUrl = URL(string: imageUrlString){
            let imageUrlRequest = URLRequest(url: imageUrl)
            
            setImageWith(imageUrlRequest, placeholderImage: nil, success: { (urlRequest, response, image) in
                // imageResponse will be nil if the image is cached
                if response != nil {
                    self.alpha = 0.0
                    self.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.alpha = 1.0
                    })
                } else {
                    self.image = image
                }
                
            }, failure: { (urlRequest, resposne, errror) in
                //
            })
        }
    }
}
