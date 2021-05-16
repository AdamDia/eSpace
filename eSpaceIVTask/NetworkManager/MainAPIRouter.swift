//
//  MainAPIRouter.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import Foundation
import Alamofire

protocol MainAPIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String  { get }
    var parameters: Parameters?  { get }
    var encoding: ParameterEncoding { get }
    var header : HTTPHeaders {get} //
}


extension MainAPIRouter {
    func asURLRequest() throws -> URLRequest {
        guard var url: URL = URL(string: NetworkConstants.baseURL) else {
            throw NetworkCustomErrors.notValidURL
        }

        url.appendPathComponent(path)
        let request = try URLRequest(url: url, method: method, headers: header)
    
        return try encoding.encode(request, with: parameters)
    }
}
