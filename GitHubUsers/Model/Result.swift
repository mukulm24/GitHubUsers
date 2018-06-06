//
//  Result.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import Foundation


// Describes the result of an asynchronous query
enum Result<T> {
    case success(T)
    case error(Error)
}
