//
//  Utils.swift
//  Genova
//
//  Created by Rahat on 02/03/24.
//

import Foundation
import UIKit

extension Array where Element: Equatable {
    mutating func removeIfPresentOrAdd(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
        } else {
            self.append(element)
        }
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension UIViewController {
    func loadDataFromJSONFile<T: Decodable>(fileName: String) -> [T]? {
        // Get the file URL for the JSON file
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("JSON file not found.")
            return nil
        }
        
        do {
            // Read data from the file
            let jsonData = try Data(contentsOf: fileURL)
            
            // Parse JSON data into an array of objects of type T
            return try JSONDecoder().decode([T].self, from: jsonData)
            
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}
extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: nil)
        self.register(nib, forCellReuseIdentifier: className)
    }
}
extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: className)
    }
}
extension UINavigationController {
    func popToViewControllerOfType<T: UIViewController>(_ type: T.Type, animated: Bool = true) {
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if let desiredViewController = viewController as? T {
                    navigationController?.popToViewController(desiredViewController, animated: true)
                    break
                }
            }
        }
    }
}
extension UIButton {
    func addBorder(color: UIColor = .black, width: CGFloat = 1.0, cornerRadius: CGFloat = 5.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 15, height: 15))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
    func addBottomBorder(_ color: CGColor = UIColor.black.cgColor){
        DispatchQueue.main.async {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
            bottomLine.backgroundColor = color
            self.borderStyle = .none
            self.layer.addSublayer(bottomLine)
        }
    }
}
