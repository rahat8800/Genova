//
//  AddressViewController.swift
//  Genova
//
//  Created by Rahat on 02/03/24.
//

import UIKit

class AddressViewController: UIViewController,UITextFieldDelegate { //
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtFullname: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPoBox: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var btnSameAddress: UIButton!
    @IBOutlet weak var btnDefaultAddress: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    
    
    let titleArr = ["Men", "Women", ]
    let cityArr = ["DUBAI", "ABU DHABI","SHARJAH" ]
    let stateArr = ["UNITED ARAB EMIRATES" ]
    var productData:[Product]?
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialViewSetup()
    }
    func initialViewSetup(){
        txtTitle.tintColor = UIColor.black
        txtTitle.delegate = self
        txtCity.delegate = self
        txtCountry.delegate = self
        txtFullname.delegate = self
        txtAddress.delegate = self
        txtPoBox.delegate = self
        txtPhone.delegate = self
        // Set up UIPickerView
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        // Set up text field
        txtTitle.inputView = pickerView1
        txtCity.inputView = pickerView2
        txtCountry.inputView = pickerView3
        // Do any additional setup after loading the view.
        btnSameAddress.addTarget(self, action: #selector(btnSameAddressTapped), for: .touchUpInside)
        btnDefaultAddress.addTarget(self, action: #selector(btnDefaultAddressTapped), for: .touchUpInside)
        
        txtTitle.setIcon(UIImage(named: "down-arrow")!)
        txtCity.tintColor = UIColor.black
        txtCity.setIcon(UIImage(named: "down-arrow")!)
        txtCountry.tintColor = UIColor.black
        txtCountry.setIcon(UIImage(named: "down-arrow")!)
        
        txtTitle.addBottomBorder()
        txtFullname.addBottomBorder()
        txtAddress.addBottomBorder()
        txtPoBox.addBottomBorder()
        txtCity.addBottomBorder()
        txtCountry.addBottomBorder()
        txtPhone.addBottomBorder()
    }
    
    @objc func btnSameAddressTapped(){
        btnSameAddress.isSelected = !btnSameAddress.isSelected
        
    }
    @objc func btnDefaultAddressTapped(){
        btnDefaultAddress.isSelected = !btnDefaultAddress.isSelected
    }
    @IBAction func btnConfirmOrderTapped(_ sender: Any) {
        if validateTextFields() {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController
            vc?.items = productData ?? []
            vc?.address = txtFullname.text! + "\n" + txtAddress.text! + "," + txtPoBox.text! + "\n" + txtCity.text! + ", " + txtCountry.text! + "\n" + txtPhone.text!
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func isValidLength(_ input: String, min: Int, max: Int) -> Bool {
        return input.count >= min && input.count <= max
    }
    
    func containsAlphabets(_ input: String) -> Bool {
        let alphaRegex = ".*[a-zA-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", alphaRegex).evaluate(with: input)
    }
    func containsNumbers(_ input: String) -> Bool {
        let numberRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: input)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addBottomBorder()
    }
}
extension AddressViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case pickerView1:
            return titleArr.count
        case pickerView2:
            return cityArr.count
        case pickerView3:
            return stateArr.count
            
        default:
            return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pickerView1:
            return titleArr[row]
        case pickerView2:
            return cityArr[row]
        case pickerView3:
            return stateArr[row]
            
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pickerView1:
            txtTitle.text = titleArr[row]
            txtTitle.resignFirstResponder() // Dismiss the picker view after selection
        case pickerView2:
            txtCity.text = cityArr[row]
            txtCity.resignFirstResponder() // Dismiss the picker view after selection
        case pickerView3:
            txtCountry.text = stateArr[row]
            txtCountry.resignFirstResponder() // Dismiss the picker view after selection
            
        default:
            break
        }
    }
}
extension AddressViewController {
    // MARK: - Validation Function
    
    func validateTextFields() -> Bool {
        var isValid = true
        
        // Validate textField1
        if let text1 = txtFullname.text, !text1.isEmpty {
            // Perform specific validation for textField1
            if !isValidLength(text1, min: 3, max: 10) {
                // Show error message or handle invalid input
                txtFullname.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            // textField1 is empty, handle the error condition
            txtFullname.addBottomBorder(UIColor.red.cgColor)
            isValid = false
        }
        
        // Validate textField2
        if let text2 = txtAddress.text, !text2.isEmpty {
            // Perform specific validation for textField2
            if !containsAlphabets(text2) {
                // Show error message or handle invalid input
                txtAddress.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            txtAddress.addBottomBorder(UIColor.red.cgColor)
            // textField2 is empty, handle the error condition
            isValid = false
        }
        // Validate textField2
        if let text2 = txtPoBox.text, !text2.isEmpty {
            // Perform specific validation for textField2
            if !containsAlphabets(text2) {
                // Show error message or handle invalid input
                txtPoBox.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            // textField2 is empty, handle the error condition
            txtPoBox.addBottomBorder(UIColor.red.cgColor)
            isValid = false
        }
        
        // Validate textField2
        if let text2 = txtPhone.text, !text2.isEmpty {
            // Perform specific validation for textField2
            if !containsNumbers(text2) {
                // Show error message or handle invalid input
                txtPhone.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            // textField2 is empty, handle the error condition
            txtPhone.addBottomBorder(UIColor.red.cgColor)
            isValid = false
        }
        
        if let text2 = txtTitle.text, !text2.isEmpty {
            // Perform specific validation for textField2
            if !containsAlphabets(text2) {
                // Show error message or handle invalid input
                txtTitle.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            // textField2 is empty, handle the error condition
            txtTitle.addBottomBorder(UIColor.red.cgColor)
            isValid = false
        }
        if let text2 = txtCity.text, !text2.isEmpty {
            // Perform specific validation for textField2
            if !containsAlphabets(text2) {
                // Show error message or handle invalid input
                txtCity.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            // textField2 is empty, handle the error condition
            txtCity.addBottomBorder(UIColor.red.cgColor)
            isValid = false
        }
        if let text2 = txtCountry.text, !text2.isEmpty {
            // Perform specific validation for textField2
            if !containsAlphabets(text2) {
                // Show error message or handle invalid input
                txtCountry.addBottomBorder(UIColor.red.cgColor)
                isValid = false
            }
        } else {
            // textField2 is empty, handle the error condition
            txtCountry.addBottomBorder(UIColor.red.cgColor)
            isValid = false
        }
        
        // Add more validation for additional text fields as needed
        
        return isValid
    }
}
