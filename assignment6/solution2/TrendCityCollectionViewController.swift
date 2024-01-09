//
//  TrendCityCollectionViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/09.
//

import UIKit
import Kingfisher

let list: [City] = CityInfo().city

class TrendCityCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
// 1. 생성한 xib 파일 연결 - nibName
        let xib = UINib(nibName: "TrendCityCollectionViewCell", bundle: nil)
        
        collectionView.register(xib, forCellWithReuseIdentifier: "TrendCityCollectionViewCell")
// 2. 레이아웃
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20
        
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 3))/2
        
        
        //1) 셀크기
        let cellHeight = cellWidth + 80
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //2) sectionInset
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        //3) minimumLineSpacing
        layout.minimumLineSpacing = spacing
        
        //4) minimumInteritItemSpacing
        layout.minimumInteritemSpacing = spacing
        
        //5) 스크롤 방향
//        layout.scrollDirection = .vertical
        
        //6) 콜렉션뷰 레이아웃 삽입
        collectionView.collectionViewLayout = layout
        
    }

    //1. 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
    }
    //2. 셀 디자인
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendCityCollectionViewCell", for: indexPath) as! TrendCityCollectionViewCell
    
        let url = URL(string: list[indexPath.item].city_image)!
        
        cell.imageView.kf.setImage(with: url)
        
        let idxItem = list[indexPath.item]
        cell.titleLabel.text =  "\(idxItem.city_name)| \(idxItem.city_english_name)"
        
        cell.subtitleLabel.text = idxItem.city_explain
        
        return cell
    }

}
