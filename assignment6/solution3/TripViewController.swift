//
//  TripViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/09.
//

import UIKit

//var domestics: [City] = []
//var overseas: [City] = []
var newList: [City] = []


enum userSelect: String, CaseIterable {
    case all = "모두"
    case dome = "국내"
    case 헤외 = "해외"
}

let selects = userSelect.allCases


class TripViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
   
    //1. 아울렛으로 만든 콜렉션 뷰 연결
    @IBOutlet var tripCollectionView: UICollectionView!
    @IBOutlet var citySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        citySegment.setTitle(selects[0].rawValue, forSegmentAt: 0)
//        citySegment.setTitle(selects[1].rawValue, forSegmentAt: 1)
//        citySegment.setTitle(selects[2].rawValue, forSegmentAt: 2)
//        
        let xib = UINib(nibName: "TrendCityCollectionViewCell", bundle: nil)
        
        //2. register
        tripCollectionView.register(xib, forCellWithReuseIdentifier: "TrendCityCollectionViewCell")
        
        //3. self로 연결
        tripCollectionView.dataSource = self
        tripCollectionView.delegate = self
     
        //4. layout
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 3))/2
        
        //1) 셀크기
        let cellHeight = cellWidth + 80
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        tripCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendCityCollectionViewCell", for: indexPath) as! TrendCityCollectionViewCell
        
        let idxItem = list[indexPath.item]
        cell.subtitleLabel.text = idxItem.city_explain
        
        let url = URL(string: list[indexPath.item].city_image)!
        
        cell.imageView.kf.setImage(with: url)
        
        cell.titleLabel.text =  "\(idxItem.city_name)| \(idxItem.city_english_name)"
        
        cell.subtitleLabel.text = idxItem.city_explain
        
        if list[indexPath.item].domestic_travel {
            
        }
        return cell
    }

   
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
      print(idx)
        }
    
    
}
