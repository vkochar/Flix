//
//  Video.swift
//  Flix
//
//  Created by Varun on 9/16/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation

class Video: NSObject {
    
    var key: String!
    var name: String!
    var site: String!
    var url: String?
    
    convenience init(json: NSDictionary) {
        self.init()
        key = json.value(forKey:"key") as? String
        name = json.value(forKey:"name") as? String
        site = json.value(forKey:"site") as? String
        
        if (site != nil && site.lowercased().range(of: "youtube") != nil) {
            if let key = key {
                url = "https://www.youtube.com/embed/\(key)?autoplay=1"
            }
        }
    }
    
}
