//
//  FoodRecipeDetailsViewController.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
import SafariServices

class FoodRecipeDetailsVC: UIViewController, SFSafariViewControllerDelegate {
    
    
    var recipeId: String = ""
    let viewModel = FoodRecipeDetailsVM()
    let disposeBag = DisposeBag()
    var safariSourceURL: String?
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var sourceURLBtn: UIButton!
    
    @IBAction func sourceBtnPressed(_ sender: Any) {
        guard let url = safariSourceURL else { return }
        if let sourceURL = URL(string: url) {
            let vc = SFSafariViewController(url: sourceURL)
            vc.delegate = self

            present(vc, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ingredientsTableView.delegate = self
        viewModel.getRecipeDetails(ids: recipeId)
        bindingVM_To_VC()
    }
    
    private func bindingVM_To_VC() {
        
        
        viewModel.recipeDetailsDataObservable.subscribe(onNext: { [weak self] recipeDetails in
            guard let self = self else { return }
            let data = recipeDetails.recipe
            
                guard let url = URL(string: data.imageURL) else { return }
                let imageRecourse = ImageResource(downloadURL: url)
                self.recipeImage.kf.setImage(with: imageRecourse)
                self.recipeTitle.text = data.title
                self.sourceURLBtn.setTitle(data.sourceURL, for: .normal)
                self.safariSourceURL = data.sourceURL
           
            
        }).disposed(by: disposeBag)
        
        viewModel.IngredientsObservable.bind(to: ingredientsTableView.rx.items(cellIdentifier: "RecipeCell")) { (index, data, cell) in
            cell.textLabel?.text = data
            
        }.disposed(by: disposeBag)
    }
    

}

extension FoodRecipeDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
