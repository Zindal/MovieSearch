//
//  NetworkServices.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServices {
    
    static let shared = NetworkServices()

    private let decoder = JSONDecoder()
    static let APIKEY = "4524dbe1cb31c1afbf85b85e0f8963c2"
    let baseImgURL = "https://image.tmdb.org/t/p/w500"

    typealias Completion<T> = (RequestResult<T>) -> Void
    
    public func getMovieList(page:Int,completion: @escaping Completion<MovieListModel>) {
        
        let requestUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + NetworkServices.APIKEY + "&page=" + "\(page)"
        
        AF.request(requestUrlString, headers: nil)
            .responseJSON { response in
                if response.error != nil {
                    completion(.failure(error: "Failed to fetch data"))
                } else {
                    do {
                        let results = try self.decoder.decode(MovieListModel.self, from: response.data ?? Data())
                        completion(.success(object: results))
                    } catch {
                        completion(.failure(error: "Failed to fetch data"))
                    }
                }
        }
    }
    
    public func searchMovieList(page:Int,query:String,completion: @escaping Completion<MovieListModel>) {
        
        let requestUrlString = "https://api.themoviedb.org/3/search/movie?api_key=" + NetworkServices.APIKEY + "&page=" + "\(page)" + "&query=" + query.replacingOccurrences(of: " ", with: "%20")
        
        AF.request(requestUrlString, headers: nil)
            .responseJSON { response in
                if response.error != nil {
                    completion(.failure(error: "Failed to fetch data"))
                } else {
                    do {
                        let results = try self.decoder.decode(MovieListModel.self, from: response.data ?? Data())
                        completion(.success(object: results))
                    } catch {
                        completion(.failure(error: "Failed to fetch data"))
                    }
                }
        }
    }

}
