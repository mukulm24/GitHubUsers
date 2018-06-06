//
//  UserSearch.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import Foundation
import Alamofire




class UserSearch {
    
    func searchUsers(_ query: SearchQuery, callback: @escaping (Result<[User]?>) -> ())  {
        
        
        let requestUrl = "https://api.github.com/search/users"
        
        let data = [
            "q" : query.text,
            "sort" : "followers"
        ]
        
        Alamofire.request(requestUrl, method: .get,parameters: data ,encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            switch response.result {
                
            case .success(let responseObject) :
                 Logger.log(message: responseObject, event: .info)
                 DispatchQueue.main.async {
                    // parse the results, then filter based on date
                    let responseDict =  responseObject as! NSDictionary
                    let result = self.parseUsersSearchResult(searchResult: responseDict)
                    callback(Result.success(result))
                   
                }
                
            case .failure(let error) :
                if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                }
                
            }
        })
    }
    
    private func parseUsersSearchResult(searchResult: NSDictionary) -> [User]? {
        
        guard let usersList = searchResult["items"] as? [NSDictionary] else {
            return nil
        }
        
        let parsedUsers = usersList.map {
            userDict -> User? in
            guard let login = userDict["login"] as? String,
                  let score = userDict["score"] as? Float else {
                    return nil
            }
            return User(login: login, score: String(describing:score))
            }
            .flatMap { $0 }
        
        return parsedUsers

        
    }
    
}
