//
//  RecipeRepositry.swift
//  eSpaceIVTask
//
//  Created by Adam on 16/05/2021.
//

import Foundation
import Foundation
import Alamofire
import RxSwift
import RxCocoa

protocol RecipesRepositry {
    
    func searchRecipesDetails(searchQuery: String) -> Observable<FoodDataModel>
    func getSingleRecipe(recipeId: String) -> Observable<SingleRecipeData>
    
}


class RecipesRepositoryClass: RecipesRepositry{
    
    let networkClient : NetworkAPICaller
    init(networkClient : NetworkAPICaller = NetworkAPICaller()) {
        self.networkClient = networkClient
    }
    
    func searchRecipesDetails(searchQuery: String) -> Observable<FoodDataModel> {
        Observable<FoodDataModel>.create{[weak self] (searchResults) -> Disposable in
            self?.networkClient.performNetworkRequest(FoodDataModel.self, router: RecipeRouter.searchRecipes(searchQuery: searchQuery)) { (result) in
                switch result{
                case .success(let data):
                    searchResults.onNext(data)
                    
                case .failure(let error):
                    searchResults.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func getSingleRecipe(recipeId: String) -> Observable<SingleRecipeData> {
        Observable<SingleRecipeData>.create{[weak self] (recipeDetails) -> Disposable in
            self?.networkClient.performNetworkRequest(SingleRecipeData.self, router: RecipeRouter.getRecipeDetails(recipeId: recipeId)) { (result) in
                switch result{
                case .success(let data):
                    recipeDetails.onNext(data)
                    
                case .failure(let error):
                    recipeDetails.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    
}
