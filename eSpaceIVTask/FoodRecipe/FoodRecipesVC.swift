//
//  FoodRecipesVC.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import DropDown



class FoodRecipesVC: UIViewController {
    
    @IBOutlet weak var foodRecipesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let dropDown = DropDown()
    let data =  UserDefaults.standard.stringArray(forKey: "list") ?? [] //["Car", "Motorcycle", "Truck", "poll", "pizza"]
    var dataFiltered: [String] = []
    
    func handleTheDropDown() {
        dropDown.anchorView = searchBar
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.backgroundColor = .white
        dropDown.direction = .bottom
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            //self.searchBar.text = item
            self.searchBar.text = item
            self.searchBar.resignFirstResponder()
        }
    }
    
    
    let viewModel = FoodRecipesVM()
    let foodRecipeDisposeBag = DisposeBag()
    var foodRecipesArray = [Recipe]()
    let foodRouter = NetworkAPICaller()
    
    let foodRecipeCell = "FoodRecipeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        handleTheDropDown()
        searchBar.delegate = self
        foodRecipesCollectionView.register(UINib(nibName: foodRecipeCell, bundle: nil), forCellWithReuseIdentifier: foodRecipeCell)
        foodRecipesCollectionView.delegate = self
        viewModel.viewDidLoad()
        bindingVM_To_VC()
    }
    
    
    private func bindingVM_To_VC() {
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: foodRecipeDisposeBag)
        viewModel.FoodRecipesDetailesObservable.bind(to: foodRecipesCollectionView.rx.items(cellIdentifier: foodRecipeCell ,cellType: FoodRecipeCell.self)){ [weak self] (index, data, cell) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                cell.foodRecipeTitle.text = data.title
                cell.foodRecipePublishedName.text = data.publisher
                guard let url = URL(string: data.imageURL) else { return }
                let resource = ImageResource(downloadURL: url)
                cell.foodRecipeImage.kf.setImage(with: resource)
                cell.getDeteailesBtn = {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodRecipeDetailsVC") as! FoodRecipeDetailsVC
                    vc.recipeId = data.recipeID
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
          
        }.disposed(by: foodRecipeDisposeBag)
    }
    
    
}


extension FoodRecipesVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFiltered = searchText.isEmpty ? data : data.filter({ (dat) -> Bool in
            dat.range(of: searchText, options: .caseInsensitive) != nil
        })

        dropDown.dataSource = dataFiltered
        dropDown.show()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        dataFiltered = data
        dropDown.hide()
    }
}

extension FoodRecipesVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 100)
    }
}

