//
//  HomeViewController.swift
//  MovieSearch
//
//  Created by Zindal on 18/10/20.
//  Copyright © 2020 zindal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var pageCount : Int! = 1
    var movieModel: [MovieInfoViewModel]! = []
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchList()
        collectionView.register(UINib(nibName: "\(MovieListCVCell.self)", bundle: nil), forCellWithReuseIdentifier: "MovieListCVCell")
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
        self.lblMessage.isHidden = false
        self.collectionView.isHidden = true
    }
    
    func handleSuccessResponse(response:MovieListModel) {
        self.movieModel.append(contentsOf: response.resultInfo ?? [])
        self.collectionView.isHidden = false
        self.lblMessage.isHidden = true
        self.collectionView.reloadData()
    }
    
    @IBAction func btnSearchClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.present(vc, animated: false, completion: nil)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCVCell", for: indexPath) as! MovieListCVCell
        cell.setUp(model: movieModel[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2 ) - 15, height: (collectionView.frame.width / 2) - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == (movieModel.count - 1) {
          self.pageCount += 1
          self.fetchList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.model = movieModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

