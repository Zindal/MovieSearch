//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var tblView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var pageCount : Int! = 1
    var movieModel: [MovieInfoViewModel]! = []

    override func viewDidLoad() {
        
        fetchList()
        tblView.register(UINib(nibName: "\(SearchTblCell.self)", bundle: nil), forCellReuseIdentifier: "SearchTblCell")

    }
    
    // MARK: Fetch Movie List with page count
    func fetchList(){
        activityIndicator.startAnimating()
        NetworkServices.shared.getMovieList(page: pageCount) { (result) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            switch result {
            case .success(let response):
                self.handleSuccessResponse(response: response)
            case .failure(let error):
                self.handleFailedResponse(error: error)
            }
        }
    }
    
    // MARK: Response handlers
    func handleFailedResponse(error:String) {
        guard self.pageCount == 1 else { return }
//        self.lblMessage.isHidden = false
        self.tblView.isHidden = true
    }
    
    func handleSuccessResponse(response:MovieListModel) {
        self.movieModel.append(contentsOf: response.resultInfo ?? [])
        self.tblView.isHidden = false
//        self.lblMessage.isHidden = true
        self.tblView.reloadData()
    }
}
