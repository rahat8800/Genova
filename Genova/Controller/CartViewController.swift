//
//  CartViewController.swift
//  Genova
//
//  Created by Rahat on 01/03/24.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTable: UITableView!
    
    var data = [Int]()
    var productData:[Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cartTable.register(cellType: CartTableViewCell.self)
    }
    
    @IBAction func btnCheckoutTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController
        vc?.productData = productData
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension CartViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.bindData(data: productData![indexPath.row])
        cell.btnCut.addTarget(self, action: #selector(btnCutTapped), for: .touchUpInside)
        cell.btnCut.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    @objc func btnCutTapped(sender:UIButton){
        productData?.remove(at: sender.tag)
        cartTable.reloadData()
    }
}
