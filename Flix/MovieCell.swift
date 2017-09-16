//
//  MovieCell.swift
//  Flix
//
//  Created by Varun on 9/15/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

let imageBaseUrl = "https://image.tmdb.org/t/p/"

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieThumbnailView: UIImageView!
    @IBOutlet weak var movieSynopsisView: UILabel!
    @IBOutlet weak var movieTitleView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(movie: Movie) {
        let imagePath = movie.posterPath
        
        if let imagePath = imagePath,
            let imageUrl = URL(string: "\(imageBaseUrl)/w185/\(imagePath)"){
            movieThumbnailView.setImageWith(imageUrl)
        }
        
        movieSynopsisView.text = movie.overview
        
        movieTitleView.text = movie.title
    }

}
