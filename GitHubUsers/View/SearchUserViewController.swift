//
//  SearchUserTableViewController.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import UIKit

/**
 Responsible to search and show the list of users sorted on the basis of Followers
 */
class SearchUserViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var searchResultsTable: UITableView!

    private let viewModel = UserSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GitHub User Search"
        bindViewModel()
    }
    
    
    func bindViewModel() {
        
        viewModel.searchString.bidirectionalBind(to:searchTextField.reactive.text)
        
        viewModel.validSearchText
            .map { $0 ? .black : .red }
            .bind(to: searchTextField.reactive.textColor)
        
        viewModel.searchResults.bind(to: searchResultsTable) { dataSource, indexPath, tableView in
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUserTableViewCell", for: indexPath) as! SearchUserTableViewCell
            let user = dataSource[indexPath.row]
           
            cell.loginLabel.text = user.login
            cell.scoreLabel.text = user.score
            
            return cell
            
        }
        
        viewModel.searchInProgress
            .map { !$0 }.bind(to: activityIndicator.reactive.isHidden)
        
        viewModel.searchInProgress
            .map { $0 ? CGFloat(0.5) : CGFloat(1.0) }
            .bind(to: searchResultsTable.reactive.alpha)
        
        _ = viewModel.errorMessages.observeNext {
            [unowned self] error in

            self.showErrorAlert(error: error)
        
         }
    }
    
    func showErrorAlert(error: String) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        let actionOk = UIAlertAction(title: "OK", style: .default,
                                     handler: { action in alertController.dismiss(animated: true, completion: nil) })
        
        alertController.addAction(actionOk)
    }
    

}
