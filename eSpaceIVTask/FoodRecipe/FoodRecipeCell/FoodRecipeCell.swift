//
//  FoodRecipeCell.swift
//  eSpaceIVTask
//
//  Created by Adam on 12/05/2021.
//

import UIKit

class FoodRecipeCell: UICollectionViewCell {

    
    var getDeteailesBtn  : (()->Void)?
    //MARK: - cell outlets
    @IBOutlet weak var foodRecipeImage: UIImageView!
    @IBOutlet weak var foodRecipeTitle: UILabel!
    @IBOutlet weak var foodRecipePublishedName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func cellBtnPressed(_ sender: Any) {
        getDeteailesBtn?()
    }
    
}
