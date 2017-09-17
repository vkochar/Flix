//
//  VideoViewController.swift
//  Flix
//
//  Created by Varun on 9/16/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var videoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = videoUrl,
            let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest)
        }
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
