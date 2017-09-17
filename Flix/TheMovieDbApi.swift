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
    
    class func getMovies(_ movieListType: String, successCallback: @escaping ([Movie]) -> Void, errorCallback: ((NSError?) -> Void)?) {
        fetchMovies(url: "\(baseUrl)/\(movieListType)", params: params, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    private class func fetchMovies(url: String, params: [String:String], successCallback: @escaping ([Movie]) -> Void, errorCallback: ((NSError?) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
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
    
    class func getVideos(forMovie id: NSNumber, successCallback: @escaping ([Video]) -> Void, errorCallback: ((NSError?) -> Void)?) {
        
        let url = "\(baseUrl)/\(id)/videos"
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        manager.get(url, parameters: params, progress: nil, success: { (operation, response) -> Void in
            if let response = response as? NSDictionary,
                let results = response["results"] as? NSArray {
                
                var videos: [Video] = []
                
                for result in results {
                    if let result = result as? NSDictionary {
                        videos.append(Video(json:result))
                    }
                }
                successCallback(videos)
            }
        },failure: { (operation, error) -> Void in
            if let errorCallback = errorCallback {
                errorCallback(error as NSError)
            }
        })

    }
}
