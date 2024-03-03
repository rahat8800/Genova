//
//  DetailViewController.swift
//  Genova
//
//  Created by Rahat on 29/02/24.
//

import UIKit

class DetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescp: UILabel!
    
    
    var currentIndex = 0
    var timer : Timer?
    var data:Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.register(cellType: SliderCell.self)
      //  startTimer()
        lblName.text = data?.title
        lblPrice.text = "\(data?.price ?? 0.00)"
        lblDescp.text = data?.description
        
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < (data?.images.count ?? 0) - 1) ? currentIndex + 1 : 0
        collection.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.images.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
       
        cell.image.sd_setImage(with:URL(string: data!.images[indexPath.item])  , placeholderImage: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
