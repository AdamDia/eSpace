//
//  NetworkCustomErrors.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import Foundation

enum NetworkCustomErrors: String, Error {
    case failedToConvertData  = "Failed to connect, Please try again"
    case notValidURL          = "Not valid URL check the URL again"
    case networkRequestFailed = "failed to connect, Please try again"
}
