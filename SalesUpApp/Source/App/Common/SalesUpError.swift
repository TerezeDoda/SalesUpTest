//
//  SalesUpError.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

enum SalesUpError: Error {
    case server
    case data
    case database
    case databaseLoadFailure
    case general
    case network
    case parsing
}
