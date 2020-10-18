//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    @IBOutlet var titleView: UIView!
    @IBOutlet var imgPosterView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblVote: UILabel!
    @IBOutlet var lblLanguage: UILabel!
    @IBOutlet var lblReleaseDate: UILabel!
    @IBOutlet var lblAdultStatus: UILabel!
    @IBOutlet var lblDetails: UILabel!
    var model: MovieInfoViewModel!

    // MARK: Life cycle
    override func viewDidLoad() {
        setUp(model: model)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
     
    // MARK: Custome methods
    func setUp(model:MovieInfoViewModel) {
         imgPosterView.sd_setImage(with: URL(string: NetworkServices.shared.baseImgURL + (model.posterPath ?? "")), placeholderImage: nil)
         lblTitle.text = model.original_title
         lblVote.text = "\(model.vote_average ?? 0)"
        
        lblLanguage.text = model.original_language ?? "-"
        lblAdultStatus.text = (model.adult ?? false) ? "Yes" : "N0"
        lblReleaseDate.text = model.release_date ?? "-"
        lblDetails.text = model.overview ?? "-"

     }

    // MARK: IBActions
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
