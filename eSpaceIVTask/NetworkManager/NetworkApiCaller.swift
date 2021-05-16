//
//  NetworkApiCaller.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import Foundation
import Alamofire

class NetworkAPICaller {
    
    func performNetworkRequest<T: Decodable>(_ object: T.Type, router: MainAPIRouter, completion: @escaping (Result< T, NetworkCustomErrors>) -> Void) {
        AF.request(router).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            if  statusCode == 200 || statusCode == 201 {
                do {
                    print("entered do")
                    guard let data  = response.data else { return }
                    print("the data", data)
                    let decoder = JSONDecoder()
                    let dataModels = try decoder.decode(T.self, from: data)
                    completion(.success(dataModels))
                } catch {
                    print("entered catch")
                    completion(.failure(.failedToConvertData))
                }
            } else {
                completion(.failure(.networkRequestFailed))
            }
        }
        
    }
    
}
