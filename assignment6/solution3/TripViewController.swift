//
//  TripViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/09.
//

import UIKit

var domestics: [City] = []
var overseas: [City] = []
var newList: [City] = []

enum userSelect: Int, CaseIterable {
    case 모두
    case 국내
    case 해외
}

let selects = userSelect.allCases.enumerated()

class TripViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //1. 아울렛으로 만든 콜렉션 뷰 연결
    @IBOutlet var tripCollectionView: UICollectionView!
    @IBOutlet var citySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newList = list
        
        for item in list{
            item.domestic_travel ? domestics.append(item) : overseas.append(item)
        }
        
        let xib = UINib(nibName: "TrendCityCollectionViewCell", bundle: nil)
        
        //2. register
        tripCollectionView.register(xib, forCellWithReuseIdentifier: "TrendCityCollectionViewCell")
        
        //3. self로 연결
        tripCollectionView.dataSource = self
        tripCollectionView.delegate = self
        
        //4. layout
        let layout = designLayout()
        tripCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! TrendCityCollectionViewCell
        
        
        //cell, idxitem,
        let idxItem = newList[indexPath.item]
        
        let url = URL(string: idxItem.city_image)!
        
        cell.imageView.kf.setImage(with: url)
        
        cell.titleLabel.text =  "\(idxItem.city_name)| \(idxItem.city_english_name)"
        
        cell.subtitleLabel.text = idxItem.city_explain
        
        return cell
    }
    
    
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        
        let idx = sender.selectedSegmentIndex
      
        let selectedDomenestic = userSelect.국내.rawValue
        let selectedOverseas = userSelect.해외.rawValue
        
        switch idx {
            // idx 1일때 list domenestic = true -> nweList 를 필터링된 배열
        case selectedDomenestic:
            newList = domestics
            //idx 2일때 list domenestic = false -> nweList 를 필터링된 배열
        case selectedOverseas:
            newList = overseas
        default:
            //전체 list idx 0일때
            newList = list
        }
        tripCollectionView.reloadData()
    }
    
}

extension TripViewController: UIConfigureProtocol{
    var id: String {
        get {
            "TrendCityCollectionViewCell"
        }
        set {
            
        }
    }
     
     func designLayout() -> UICollectionViewFlowLayout{
         let layout = UICollectionViewFlowLayout()
         let spacing: CGFloat = 20
         let cellWidth = (UIScreen.main.bounds.width - (spacing * 3))/2
         let cellHeight = cellWidth + 80
         
         layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
         layout.minimumLineSpacing = spacing
         layout.minimumInteritemSpacing = spacing
         return layout
     }
}
