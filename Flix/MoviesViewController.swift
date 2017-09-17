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
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var movieListType: String!
    var movies:[Movie] = []
    
    var _filteredMovieList:[Movie]?
    var filteredMovieList:[Movie] {
        set(value) {
            _filteredMovieList = value
        }
        get {
            if _filteredMovieList == nil || _filteredMovieList!.count == 0 {
                return movies
            } else {
                return _filteredMovieList!
            }
        }
    }
    
    var succesCallback: (([Movie])-> Void)?
    var errorCallback: ((NSError?) -> Void)?
    
    var layout: UICollectionViewFlowLayout?
    var isGrid: Bool = false
    
    let gridSize = CGSize(width: 187, height: 282)
    let cellSize = CGSize(width: 375, height: 116)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        layout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout!.itemSize = cellSize
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        moviesCollectionView.insertSubview(refreshControl, at: 0)
        
        showError(show: false)
        
        succesCallback = {movies in
            self.showError(show: false)
            self.movies = movies
            self.moviesCollectionView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
        }
        
        errorCallback = {error in
            self.movies.removeAll()
            self.filteredMovieList.removeAll()
            self.moviesCollectionView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showError(show: true)
            refreshControl.endRefreshing()
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        TheMovieDbApi.getMovies(movieListType, successCallback: succesCallback!, errorCallback: errorCallback!)
    }
    
    private func addSearchBar() {
        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
    }
    
    @IBAction func didClickChangeLayoutButton(_ sender: UIBarButtonItem) {
        if (isGrid) {
            layout!.itemSize = cellSize
            sender.image = #imageLiteral(resourceName: "list")
            //sender.setBackgroundImage(#imageLiteral(resourceName: "list"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        } else {
            layout!.itemSize = gridSize
            sender.image = #imageLiteral(resourceName: "grid")
            //sender.setBackgroundImage(#imageLiteral(resourceName: "grid"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        }
        isGrid = !isGrid
        
        moviesCollectionView.reloadData()
    }
    
    private func showError(show: Bool) {
        errorLabel.isHidden = !show
        if (show){
            errorLabel.frame.size.height = 21
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
        let cell = sender as! UICollectionViewCell
        let indexPath = moviesCollectionView.indexPath(for: cell)
        let movie = filteredMovieList[indexPath!.row]
        
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
        
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.gray
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(red: 243/255, green: 188/255, blue: 97/255, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = filteredMovieList[indexPath.row]
        
        if(isGrid) {
            let movieGrid = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGrid", for: indexPath) as! MovieGrid
            movieGrid.set(movie: movie)
            return movieGrid
        } else {
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            movieCell.set(movie: movie)
            return movieCell
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            filteredMovieList = movies
        } else {
            let searchTextLowercased = searchText.lowercased()
            filteredMovieList = movies.filter { (movie: Movie) -> Bool in
                return movie.title.lowercased().range(of: searchTextLowercased) != nil
                    || movie.description.lowercased().range(of: searchTextLowercased) != nil
            }
        }
        moviesCollectionView.reloadData()
    }
}

