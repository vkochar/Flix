//
//  MoviesViewController.swift
//  Flix
//
//  Created by Varun on 9/15/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movieListType: String! = ""
    var movies:[Movie] = []
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let succesCallback: ([Movie])-> Void = {movies in
            self.movies = movies
            self.moviesTableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        
        let errorCallback: (NSError?) -> Void = {error in
            
        }
        
        if (movieListType == "now_playing") {
            TheMovieDbApi.getNowPlaying(successCallback: succesCallback, errorCallback: errorCallback)
        } else {
            TheMovieDbApi.getTopRated(successCallback: succesCallback, errorCallback: errorCallback)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        movieCell.set(movie: movie)
        return movieCell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
