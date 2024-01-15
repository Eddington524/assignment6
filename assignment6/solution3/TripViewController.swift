//
//  TripViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/09.
//

import UIKit

var domestics: [City] = []
var overseas: [City] = []

enum userSelect: Int, CaseIterable {
    case 모두
    case 국내
    case 해외
}

class TripViewController: UIViewController{
    
    //1. 아울렛으로 만든 콜렉션 뷰 연결
    @IBOutlet var tripCollectionView: UICollectionView!
    @IBOutlet var citySegment: UISegmentedControl!
    
    @IBOutlet var searchBar: UISearchBar!
    
    let originalList:[City] = list
    var segmentedList: [City] = []
    var newList: [City] = CityInfo.city {
        didSet {
            tripCollectionView.reloadData()
        }
    }
    var segmentIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newList = originalList
        
        for item in originalList{
            item.domestic_travel ? domestics.append(item) : overseas.append(item)
        }
        
        configureCollectionView()
        
        let layout = designLayout()
        tripCollectionView.collectionViewLayout = layout
        
        // 취소버튼 보이게
        searchBar.showsCancelButton = true
    }
    
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        
        let idx = sender.selectedSegmentIndex
        segmentIdx = idx
        
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
            newList = originalList
        }
//        tripCollectionView.reloadData()
    }
    
}

extension TripViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        //3. self로 연결
        tripCollectionView.dataSource = self
        tripCollectionView.delegate = self
        
        let xib = UINib(nibName: TrendCityCollectionViewCell.identifier, bundle: nil)
        
        //2. register
        tripCollectionView.register(xib, forCellWithReuseIdentifier: TrendCityCollectionViewCell.identifier)
        
    }
}

extension TripViewController: UIConfigureProtocol{
    
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

extension TripViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendCityCollectionViewCell", for: indexPath) as! TrendCityCollectionViewCell
        
        
        //cell, idxitem,
        let idxItem = newList[indexPath.item]
        
        let url = URL(string: idxItem.city_image)!
        
        cell.imageView.kf.setImage(with: url)
        
        cell.titleLabel.text =  "\(idxItem.city_name)| \(idxItem.city_english_name)"
        
        cell.subtitleLabel.text = idxItem.city_explain
        
        return cell
    }
    
    // 관광지 리스트로 화면전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //1. 스토리보드 연결
        let sb = UIStoryboard(name: "CityDetail", bundle: nil)
        
        let vc =  sb.instantiateViewController(withIdentifier: "DetailViewController")
        
        // root 뷰의 navigation이 있어야함! 스토리보드에서 추가함
        navigationController?.pushViewController(vc, animated: true)
        //
        print("\(indexPath.row)")
    }
    
    
}


extension TripViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var filterData: [City] = []
        
        if segmentIdx != 0 {
            segmentedList = newList
        }else{
            segmentedList = originalList
        }
        
        if searchBar.text == "" {
            newList = segmentedList
        }else{
            for item in segmentedList {
                if item.city_name.contains(searchBar.text!) || item.city_english_name.contains(searchBar.text!) || item.city_explain.contains(searchBar.text!){
                    
                    filterData.append(item)
                }
            }
            newList = filterData
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var filterData: [City] = []
        
        if segmentIdx != 0 {
            segmentedList = newList
        }else{
            segmentedList = originalList
        }
        
        if searchBar.text == "" {
            newList = segmentedList
        }else{
            for item in segmentedList {
                if item.city_name.contains(searchBar.text!) || item.city_english_name.contains(searchBar.text!) || item.city_explain.contains(searchBar.text!){
                    
                    filterData.append(item)
                }
            }
            newList = filterData
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        if segmentIdx == 0 {
            segmentedList = originalList
        }else if segmentIdx == 1{
            segmentedList = domestics
        }else{
            segmentedList = overseas
        }
    
        newList = segmentedList
    }
}
