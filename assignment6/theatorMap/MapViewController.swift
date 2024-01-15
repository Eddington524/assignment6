//
//  MapViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/15.
//

import UIKit
import MapKit

class MapViewController: UIViewController {


    @IBOutlet var mapView: MKMapView!
    
    let originList: [Theater] = TheaterList.mapAnnotations
    let fitteredList: [Theater] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setMap(list: originList)
        
        setNavigationItem()
       
    }

    func setNavigationItem() -> Void {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
    @objc func rightBarButtonItemClicked(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //2.버튼
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
//        {
//            _ in self.selected = ""
//            
//            self.setMap(list: self.originList)
//        }
        
        let megaboxButton = UIAlertAction(title: TheaterType.메가박스.rawValue, style: .default){ _ in
            
            self.filterList(type: TheaterType.메가박스.rawValue )
            
        }
        
        let cgvButton = UIAlertAction(title: TheaterType.CGV.rawValue, style: .default){_ in
            
            self.filterList(type: TheaterType.CGV.rawValue)
        }
        
        let lotteButton = UIAlertAction(title: TheaterType.롯데시네마.rawValue, style: .default){
            _ in
            
            self.filterList(type: TheaterType.롯데시네마.rawValue)
        }
        
        let nonFilterButton = UIAlertAction(title: "전체보기", style: .default) {
            _ in 
            
            self.setMap(list: self.originList)
        }
        
        //3.컨텐츠 + 버튼
        alert.addAction(megaboxButton)
        alert.addAction(cgvButton)
        alert.addAction(lotteButton)
        alert.addAction(nonFilterButton)
        alert.addAction(cancelButton)
        
        //4. 띄우기
        present(alert, animated: true)
        
    }
    
    // 1. 처음 idx "" 이면 originlist를 보여주기
    
    // 2. idx "CGV"이면 list를 cgv 필터된 배열로 보여주기
    
    // 3. idx ""

    func setMap(list:[Theater]) {
        
        // 필터링 하기 전에 이전 어노테이션 지워주기
        mapView.removeAnnotations(mapView.annotations)
        
        for item in list {
            
            let coordicate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            
            let region = MKCoordinateRegion(center: coordicate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordicate
            annotation.title = item.location
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func filterList(type: String){
        let list = self.originList.filter{$0.type == type}
        
        self.setMap(list: list)
    }
}

