//
//  MovieListModel.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import Foundation

enum RequestResult<T> {
    case success(object: T)
    case failure(error: String)
}

class MovieListModel: Decodable {
    
    let resultInfo:[MovieInfoViewModel]?
    let page: Int?
    let total_results: Double?
    let total_pages: Int?
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case total_results
        case total_pages
    }
    
    required public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resultInfo = try container.decode([MovieInfoViewModel].self, forKey: .results)
        page = try container.decode(Int.self, forKey: .page)
        total_results = try container.decode(Double.self, forKey: .total_results)
        total_pages = try container.decode(Int.self, forKey: .total_pages)
    }
    
}
