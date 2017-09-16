//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Varun on 9/15/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        overviewLabel.sizeToFit()
        
        if let imagePath = movie.posterPath {
            let lowResImageUrlString = "\(imageBaseUrl)/w185/\(imagePath)"
            let highResImageUrlString = "\(imageBaseUrl)/w500/\(imagePath)"
            
            posterImageView.setLowResAndHighResImage(lowResImageUrlString: lowResImageUrlString, highResImageUrlString: highResImageUrlString)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
                                        height: infoView.frame.origin.y + overviewLabel.frame.size.height + 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
