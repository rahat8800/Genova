//
//  CheckoutViewController.swift
//  Genova
//
//  Created by Rahat on 02/03/24.
//

import UIKit

class AddressTableCell:UITableViewCell{
    
    @IBOutlet weak var lblAdd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblAdd.numberOfLines = 0
    }
}

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var itemsCollView: UICollectionView!
    @IBOutlet weak var addTableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblVat: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblSurch: UILabel!
    @IBOutlet weak var lblShip: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    
    var items = [Product](){
        didSet {
            
        }
    }
    var address:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemsCollView.register(cellType: HomeCollectionViewCell.self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.itemsCollView.reloadData()
        }
        
        let total = items.map { $0.price }.reduce(0, +)
        let perc = total * 0.05
        let percentage = (perc * 100).rounded() / 100
        let surch = 10.00
        lblTotal.text = "\(total) AED"
        lblVat.text = String(percentage) + " AED"
        lblDiscount.text = "0.00 AED"
        lblSurch.text = String(surch) + "AED"
        lblShip.text = "FREE"
        lblGrandTotal.text = String(total+percentage+surch) + "AED"
    }
    
   

    @IBAction func btnCompletePayTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension CheckoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.shadowDecorate()
        cell.bindData(data: items[indexPath.row])
        cell.btnCart.isHidden = true
        cell.btnLike.isHidden = true
        cell.btnCart.tag = indexPath.row
        cell.ViewPercentBg.roundCorners(corners: [.bottomRight,.topRight], radius: 8)
        
        cell.buttonTapAction = { [self] tag in
            print(tag)
            
//            carItems.removeIfPresentOrAdd(items[tag].id)
//            print(carItems) // Output: [1, 3]
            cell.btnCart.isSelected = !cell.btnCart.isSelected
        }
        
        return cell
    }
   
}
extension CheckoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat = 10
                let collectionViewWidth = collectionView.frame.width
                let cellWidth = (collectionViewWidth - padding * 3) / 2 // 3 paddings: left, right, and spacing between cells
                return CGSize(width: cellWidth, height: 270) // Adjust the height as per your requirement
            
    
    }
}
extension CheckoutViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressTableCell
        cell.lblAdd.text = address ?? ""
        return cell
    }
    
    
}
