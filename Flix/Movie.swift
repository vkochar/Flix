//
//  Movie.swift
//  Flix
//
//  Created by Varun on 9/15/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation

class Movie: NSObject {
    
    var title:String! // original_title
    var posterPath: String? // poster_path -- all movies might not have a poster
    var overview: String! // overview
    var releaseDate: String! // release_date
    
    convenience init(json: NSDictionary) {
        self.init()
        title = json.value(forKey:"original_title") as? String
        posterPath = json.value(forKey:"poster_path") as? String
        overview = json.value(forKey:"overview") as? String
        releaseDate = json.value(forKey:"release_date") as? String
    }
    
}
