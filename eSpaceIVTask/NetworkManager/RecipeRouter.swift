//
//  RecipeRouter.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import Foundation
import Alamofire


enum RecipeRouter: MainAPIRouter {

    //MARK: - registration cases
    case getRecipeDetails(recipeId: String)
    case searchRecipes(searchQuery: String)
    

    //MARK: - key features for the api call
    var method: HTTPMethod {
        switch self {
        case .getRecipeDetails, .searchRecipes:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getRecipeDetails:
            return "get"
        case .searchRecipes:
            return "search"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getRecipeDetails( let recipeId):
            let paramters: Parameters = [
                "rId": recipeId
            ]
            return paramters
            
        case .searchRecipes( let searchQuery):
            let paramters: Parameters = [
                "q": searchQuery
            ]
            
            return paramters
 
        }
        
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getRecipeDetails, .searchRecipes:
            return URLEncoding.default
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .getRecipeDetails, .searchRecipes:
            let header = HTTPHeaders([HTTPHeader(name: "Accept", value: "application/json")])
            return header
        }
    }
    
}
