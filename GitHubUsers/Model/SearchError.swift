//
//  SearchError.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import Foundation

enum SearchError: Error {
    case requestError
    case parseError
    case malformedRequest
}
