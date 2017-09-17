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
    @IBOutlet weak var playButton: UIButton!
    
    var movie: Movie!
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        overviewLabel.sizeToFit()
        
        if let imagePath = movie.posterPath {
            let lowResImageUrlString = "\(imageBaseUrl)/w185/\(imagePath)"
            let highResImageUrlString = "\(imageBaseUrl)/original/\(imagePath)"
            
            posterImageView.setLowResAndHighResImage(lowResImageUrlString: lowResImageUrlString, highResImageUrlString: highResImageUrlString)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
                                        height: infoView.frame.origin.y + overviewLabel.frame.size.height + 100)
        
        TheMovieDbApi.getVideos(forMovie: movie.id, successCallback: { videos in
            
            self.videos.append(contentsOf: videos)
            
            let playImage = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
            self.playButton.setBackgroundImage(playImage, for: UIControlState.normal)
            self.playButton.tintColor = UIColor.white
            self.playButton.isHidden = false
            self.playButton.alpha = 0
            
            UIView.animate(withDuration: 0.4, animations: {
                self.playButton.alpha = 1.0
            })
        }, errorCallback: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! VideoViewController
        
        let firstVideo = videos[0]
        if let url = firstVideo.url {
            vc.videoUrl = url
        }
    }
}
