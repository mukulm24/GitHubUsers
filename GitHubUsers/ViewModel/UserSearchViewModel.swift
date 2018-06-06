//
//  UserSearchViewModel.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

class UserSearchViewModel {
    
    let searchString = Observable<String?>("")
    let validSearchText = Observable<Bool>(false)
    let searchResults = MutableObservableArray<User>([])
    let searchInProgress = Observable<Bool>(false)
    let errorMessages = PublishSubject<String, NoError>()
    
    private let searchService: UserSearch = {
        return UserSearch()
    }()
    
    
    init() {
        searchString
            .map { $0!.count > 3 }
            .bind(to:validSearchText)
        
        _ = searchString
            .filter { $0!.count > 3 }
            .throttle(seconds: 0.5)
            .observeNext {
                [unowned self] text in
                if let text = text {
                    self.executeSearch(text)
                }
        }
        
    }
    
    func executeSearch(_ text: String) {
       
        var query = SearchQuery()
        query.text = searchString.value ?? ""
        searchInProgress.value = true
        
        searchService.searchUsers(query) {
            [unowned self] result in
            self.searchInProgress.value = false
            switch result {
            case .success(let users):
                self.searchResults.removeAll()
                if let usersList = users {
                    self.searchResults.insert(contentsOf: usersList, at: 0)
                }
            case .error:
                self.errorMessages.next("ERROR")
            }
        }
        
    }
}
