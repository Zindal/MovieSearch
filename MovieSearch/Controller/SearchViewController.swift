//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tblView: UITableView!
    var pageCount : Int! = 1
    var movieModel: [MovieInfoViewModel]! = []
    @IBOutlet var lblMessage: UILabel!
    var totalPages: Int?

    // MARK: Life cycle
    override func viewDidLoad() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        tblView.register(UINib(nibName: "\(SearchTblCell.self)", bundle: nil), forCellReuseIdentifier: "SearchTblCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Fetch Movie List with page count
    func fetchList(){
        NetworkServices.shared.searchMovieList(page: pageCount,query: searchBar.text ?? "") { (result) in
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
        self.lblMessage.isHidden = false
        self.tblView.isHidden = true
    }
    
    func handleSuccessResponse(response:MovieListModel) {
        self.totalPages = response.total_pages
        self.movieModel.append(contentsOf: response.resultInfo ?? [])
        self.tblView.isHidden = false
        self.lblMessage.isHidden = true
        self.tblView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTblCell") as! SearchTblCell
        if indexPath.row < (movieModel.count - 1) {
            cell.setUp(model: movieModel[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (movieModel.count - 1) {
            if (self.pageCount + 1) < (self.totalPages ?? 1) {
                self.pageCount += 1
                self.fetchList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.model = movieModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            self.movieModel.removeAll()
            self.fetchList()
        }
        else {
            self.movieModel.removeAll()
            self.tblView.reloadData()
        }
    }
    
}
