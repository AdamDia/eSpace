//
//  FoodRecipeDetailsVM.swift
//  eSpaceIVTask
//
//  Created by Adam on 16/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

class FoodRecipeDetailsVM {
    
    var foodRecipeDetailsVMRepo = RecipesRepositoryClass()
    let disposedBag = DisposeBag()
    
    private var recipeDetailsData: PublishSubject<SingleRecipeData> = .init()
    lazy var recipeDetailsDataObservable: Observable<SingleRecipeData> = recipeDetailsData.asObserver()
    
    var Ingredients: PublishSubject<[String]> = .init()
    lazy var IngredientsObservable: Observable = Ingredients.asObservable()
        
    
    
    func getRecipeDetails(ids: String) {
        foodRecipeDetailsVMRepo.getSingleRecipe(recipeId: ids).subscribe(onNext: { [weak self]
            (recipeData) in
            guard let self = self else { return }
            
            self.recipeDetailsData.onNext(recipeData)
            self.Ingredients.onNext(recipeData.recipe.ingredients)
            
        }).disposed(by: disposedBag)
    }
    
}
