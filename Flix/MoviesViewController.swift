//
//  MoviesViewController.swift
//  Flix
//
//  Created by Varun on 9/15/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var movieListType: String!
    var movies:[Movie] = []
    
    var succesCallback: (([Movie])-> Void)?
    var errorCallback: ((NSError?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        moviesTableView.insertSubview(refreshControl, at: 0)
        
        succesCallback = {movies in
            self.showError(show: false)
            self.movies = movies
            self.moviesTableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
        }
        
        errorCallback = {error in
            self.movies.removeAll()
            self.moviesTableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showError(show: true)
            refreshControl.endRefreshing()
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        TheMovieDbApi.getMovies(movieListType, successCallback: succesCallback!, errorCallback: errorCallback!)
    }
    
    private func showError(show: Bool) {
        if (show){
            errorLabel.frame.size.height = 44
        } else {
            errorLabel.frame.size.height = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        self.showError(show: false)
        TheMovieDbApi.getMovies(movieListType, successCallback: succesCallback!, errorCallback: errorCallback!)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = moviesTableView.indexPath(for: cell)
        let movie = movies[indexPath!.row]
        
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
        
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
}

