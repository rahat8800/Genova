//
//  ViewController.swift
//  Genova
//
//  Created by Rahat on 29/02/24.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var lblCart: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    
    var items = [Product]() {
        didSet {
            self.homeCollection.reloadData()
        }
    }
    var carItems = [Int]() {
        didSet {
            carItems.count == 0 ? (lblCart.isHidden = true) : (lblCart.isHidden = false)
            lblCart.text = "\(carItems.count)"
        }
    }
   
    var orderPlaced=false {
        didSet {
            carItems = []
            homeCollection.reloadData()
        }
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialSetup()
    }
    func initialSetup(){
        let extraBottomInset: CGFloat = 100 // Adjust this value as needed
        // Increase the bottom inset
        homeCollection.contentInset.bottom += extraBottomInset
        // Optionally, you might want to adjust the scroll indicator insets to match
        homeCollection.scrollIndicatorInsets = homeCollection.contentInset
        
        lblCart.layer.cornerRadius = 10
        lblCart.clipsToBounds = true
        homeCollection.register(cellType: HomeCollectionViewCell.self)
        
        btnCart.addTarget(self, action: #selector(btnCartTapped), for: .touchUpInside)
        
        if let products: [Product] = loadDataFromJSONFile(fileName: "DataModel") {
            self.items = products
        }
    }
    @objc func btnCartTapped(){
        if carItems.count > 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
            vc?.data = carItems
            vc?.productData = items.filter { carItems.contains($0.id) }
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

// MARK: - Table View Data Source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.shadowDecorate()
        cell.bindData(data: items[indexPath.row])
        if carItems.contains(items[indexPath.row].id) {
            cell.btnCart.isSelected = true
        }else {
            cell.btnCart.isSelected = false
        }
        
        cell.btnCart.tag = indexPath.row
        cell.ViewPercentBg.roundCorners(corners: [.bottomRight,.topRight], radius: 8)
        
        cell.buttonTapAction = { [self] tag in
            print(tag)
            
            carItems.removeIfPresentOrAdd(items[tag].id)
            print(carItems) // Output: [1, 3]
            cell.btnCart.isSelected = !cell.btnCart.isSelected
        }
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat = 10
                let collectionViewWidth = collectionView.frame.width
                let cellWidth = (collectionViewWidth - padding * 3) / 2 // 3 paddings: left, right, and spacing between cells
                return CGSize(width: cellWidth, height: 200) // Adjust the height as per your requirement
            
    
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.data = items[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}




