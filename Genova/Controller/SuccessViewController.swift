//
//  SuccessViewController.swift
//  Genova
//
//  Created by Rahat on 02/03/24.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var btnHome: UIButton!
    
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnHome.addBorder(color: .white,width: 1.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    @IBAction func backHomeTapped(_ sender: Any) {
        let a = self.navigationController?.viewControllers[0] as! ViewController
          a.orderPlaced = true
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

