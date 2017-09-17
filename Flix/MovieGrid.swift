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
        backgroundColor = UIColor(red: 240/255, green: 185/255, blue: 94/255, alpha: 1)
    }
    
    func set(movie: Movie) {
        let imagePath = movie.posterPath
        
        if let imagePath = imagePath {
            movieThumbnailView.setImageWithAnimation(imageUrlString: "\(imageBaseUrl)/w185/\(imagePath)")
        }
    }
}
