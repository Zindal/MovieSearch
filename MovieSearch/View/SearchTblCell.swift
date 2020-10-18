//
//  SearchTblCell.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import UIKit
import SDWebImage

final class SearchTblCell: UITableViewCell {

    @IBOutlet var posterImgView: UIImageView!
    @IBOutlet var lblMovieName: UILabel!
    @IBOutlet var lblAverageVote: UILabel!
    
    func setUp(model:MovieInfoViewModel) {
        posterImgView.sd_setImage(with: URL(string: NetworkServices.shared.baseImgURL + (model.posterPath ?? "")), placeholderImage: nil)
        posterImgView.layer.cornerRadius = 5.0
        posterImgView.layer.masksToBounds = true
        lblMovieName.text = model.original_title
        lblAverageVote.text = "\(model.vote_average ?? 0)"
    }
    
}
