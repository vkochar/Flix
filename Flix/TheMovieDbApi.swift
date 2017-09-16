//
//  Api.swift
//  Flix
//
//  Created by Varun on 9/15/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation
import AFNetworking


private let params = ["api_key" : "a07e22bc18f5cb106bfe4cc1f83ad8ed"]
private let baseUrl = "https://api.themoviedb.org/3/movie"

class TheMovieDbApi {
    
    class func getNowPlaying(successCallback: @escaping ([Movie]) -> Void, errorCallback: ((NSError?) -> Void)?) {
        fetchMovies(url: "\(baseUrl)/now_playing", params: params, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    class func getTopRated(successCallback: @escaping ([Movie]) -> Void, errorCallback: ((NSError?) -> Void)?) {
        fetchMovies(url: "\(baseUrl)/top_rated", params: params, successCallback:  successCallback, errorCallback:  errorCallback)
    }
    
    private class func fetchMovies(url: String, params: [String:String], successCallback: @escaping ([Movie]) -> Void, errorCallback: ((NSError?) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        
        manager.get(url, parameters: params, progress: nil, success: { (operation, response) -> Void in
            if let response = response as? NSDictionary,
                let results = response["results"] as? NSArray {
                
                var movies: [Movie] = []
                
                for result in results {
                    if let result = result as? NSDictionary {
                        movies.append(Movie(json:result))
                    }
                }
                successCallback(movies)
            }
        },failure: { (operation, error) -> Void in
            if let errorCallback = errorCallback {
                errorCallback(error as NSError)
            }
        })
        
    }
}