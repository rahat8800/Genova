//
//  CartTableViewCell.swift
//  Genova
//
//  Created by Rahat on 01/03/24.
//

import UIKit
import SDWebImage

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var btnCut: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    func bindData(data:Product){
        lblName.text = data.title
        lblPrice.text = "\(data.price)"
        lblCategory.text = data.category
        lblQuantity.text = ""
        img.sd_setImage(with:URL(string: data.thumbnail)  , placeholderImage: nil)
    }
    
}
