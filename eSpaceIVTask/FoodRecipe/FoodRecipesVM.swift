//
//  FoodRecipesVM.swift
//  eSpaceIVTask
//
//  Created by Adam on 16/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

class FoodRecipesVM {
    
    var foodVMRepo = RecipesRepositoryClass()
    let disposedBag = DisposeBag()
    
    private  var FoodRecipesDetailes : PublishSubject<[Recipe]> = .init()
    lazy var FoodRecipesDetailesObservable : Observable<[Recipe]> = FoodRecipesDetailes.asObservable()
    
    var searchText : BehaviorRelay<String> = .init(value: "")
    private var numberOfresults : BehaviorRelay<Int> = .init(value: 0)
    lazy var numberOfresulteAsobservable : Observable = numberOfresults.asObservable()
    var suggestedList = [String]()
    
    func viewDidLoad() {
        getResultOfResult()
    }
    func getResultOfResult(){
        searchText.asObservable().distinctUntilChanged().subscribe(onNext: {[weak self] (searchData) in
            guard let self = self else {return}
            self.getLatestRecipesData(searchQuery: searchData)
         
        }).disposed(by: disposedBag)
    }
    
    
    func getLatestRecipesData(searchQuery: String) {
        foodVMRepo.searchRecipesDetails(searchQuery: searchQuery).subscribe(onNext: { (searchResults) in
            if searchResults.count > 0 {
                self.FoodRecipesDetailes.onNext(searchResults.recipes)
                if searchQuery != "" {
                    if self.suggestedList.count >= 10 {
                        self.suggestedList.removeLast()
                    }
                    self.suggestedList.append(searchQuery)
                    UserDefaults.standard.set(self.suggestedList, forKey: "list")
                }
            } else {
                print("no results")
            }
            
        }).disposed(by: disposedBag)
        
    }
    
}
