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
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    required public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resultInfo = try container.decode([MovieInfoViewModel].self, forKey: .results)
    }
    
}
