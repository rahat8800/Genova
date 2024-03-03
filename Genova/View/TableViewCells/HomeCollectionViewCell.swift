//
//  HomeCollectionViewCell.swift
//  Genova
//
//  Created by Rahat on 29/02/24.
//

import UIKit
import SDWebImage


class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var ViewPercentBg: UIView!
    
    var buttonTapAction: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnLike.addTarget(self, action: #selector(btnLikeTapped), for: .touchUpInside)
        btnCart.addTarget(self, action: #selector(btnCartTapped), for: .touchUpInside)
        shadowDecorate()
    }
    @objc func btnCartTapped(sender:UIButton){
        buttonTapAction?(sender.tag)
    }
    @objc func btnLikeTapped(){
        btnLike.isSelected = !btnLike.isSelected
    }
    
    func bindData(data:Product) {
        lblOffer.text = "\(data.discountPercentage) %"
        lblCategory.text = data.category
        lblName.text = data.title
        lblPrice.text = "\(data.price)"
        imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgProduct.sd_setImage(with:URL(string: data.thumbnail)  , placeholderImage: nil)//image = SDAnimatedImage(named: data.thumbnail)
        
    }

}
extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        //contentView.layer.cornerRadius = radius
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.clear.cgColor
//        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
        
        
    }
}
