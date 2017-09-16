//
//  MovieGrid.swift
//  Flix
//
//  Created by Varun on 9/16/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class MovieGrid: UICollectionViewCell {
 
    @IBOutlet weak var movieThumbnailView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(movie: Movie) {
        let imagePath = movie.posterPath
        
        if let imagePath = imagePath {
            movieThumbnailView.setImageWithAnimation(imageUrlString: "\(imageBaseUrl)/w185/\(imagePath)")
        }
    }
}
