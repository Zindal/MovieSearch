//
//  MovieInfoViewModel.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import Foundation

class MovieInfoViewModel: Decodable {

    let popularity: Float?
    let vote_count: Double?
    let posterPath: String?
    let adult: Bool?
    let original_language: String?
    let original_title: String?
    let vote_average: Float?
    let overview: String?
    let release_date: String?

    let dateFormatter = DateFormatter()
    
    private enum CodingKeys: String, CodingKey {
        case popularity
        case vote_count
        case poster_path
        case adult
        case original_language
        case original_title
        case vote_average
        case overview
        case release_date
    }
    
    required public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try container.decode(Float.self, forKey: .popularity)
        vote_count = try container.decode(Double.self, forKey: .vote_count)
        posterPath = try container.decode(String.self, forKey: .poster_path)
        adult = try container.decode(Bool.self, forKey: .adult)
        original_language = try container.decode(String.self, forKey: .original_language)
        original_title = try container.decode(String.self, forKey: .original_title)
        vote_average = try container.decode(Float.self, forKey: .vote_average)
        overview = try container.decode(String.self, forKey: .overview)
        
        let date = try container.decode(String.self, forKey: .release_date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"
        release_date = dateFormatter.string(from: currentDate ?? Date())
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
    }
    
}

