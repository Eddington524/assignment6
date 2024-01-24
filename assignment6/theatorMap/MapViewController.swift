//
//  MapViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/15.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //0-1. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    @IBOutlet var locationButton: UIButton!
    
    @IBOutlet var mapView: MKMapView!
    
    let originList: [Theater] = TheaterList.mapAnnotations
    let fitteredList: [Theater] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0-2. 위치 프로토콜 연결
        locationManager.delegate = self
        
        setMap(list: originList)
        
        setNavigationItem()
        checkDeviceLocationAuthorization()
    }
    
    @IBAction func locationButtonClicked(_ sender: UIButton) {
        checkDeviceLocationAuthorization()
    }
    
    func setNavigationItem() -> Void {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
    @objc func rightBarButtonItemClicked(){
        let list = TheaterType.allCases
        showActionSheet(title: list) { type in
            self.filterList(type: type)
        }
    }
    
    // 1. 처음 idx "" 이면 originlist를 보여주기
    
    // 2. idx "CGV"이면 list를 cgv 필터된 배열로 보여주기
    
    // 3. idx ""

    func setMap(list:[Theater]) {
        
        // 필터링 하기 전에 이전 어노테이션 지워주기
        mapView.removeAnnotations(mapView.annotations)
        
        for item in list {
            
            let coordicate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            
            let region = MKCoordinateRegion(center: coordicate, latitudinalMeters: 400, longitudinalMeters: 400)
            
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

extension MapViewController {
    
    //1. 먼저 체크, 위치 서비스 자체를 활성화 했니??
    func checkDeviceLocationAuthorization(){
        print("test")
        //위치 서비스 enabled 이면
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                }else{
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
                
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 할 수 없어요")
            }
        }
       
    }
    
    //2. 사용자 위치 권한 상태 확인 후, 권한 요청
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            print("notDetermined")
            
            // 정확도를 정하고 요청을 해야하니까!
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denied")

//            locationManager.startUpdatingLocation()
            
            setDefaultRegion(latitude: 37.515700, longtitude: 126.907722)
            
            showLocationAlert(title: "위치정보 이용", message: "서비스를 사용할 수 없습니다", buttonTitle: "설정으로 이동") {
                
                if let setting = URL(string: UIApplication.openSettingsURLString) {
                           UIApplication.shared.open(setting)
                }else{
                    print("설정으로 가주세요")
                }
            }
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
            
        default:
            print("Error")
        }
    }
    
//    func showLocationSettingAlert() {
//        let alert = UIAlertController(title: "위치정보이용", message: "위치 서비스를 사용할 수 없습니다", preferredStyle: .alert)
//        
//        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
//            
//            if let setting = URL(string: UIApplication.openSettingsURLString) {
//                UIApplication.shared.open(setting)
//            }else{
//                print("설정으로 가주세요")
//            }
//        }
//        
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        
//        alert.addAction(goSetting)
//        alert.addAction(cancel)
//        
//        present(alert, animated: true)
//    
//    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func setDefaultRegion(latitude:Double, longtitude:Double ){
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        
        mapView.setRegion(region, animated: true)
    }
    
}


//0. 위치 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    
    // 위치 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            
            setRegionAndAnnotation(center: coordinate)
        }
        
        
//        let deniedCoordinate = CLLocationCoordinate2D(latitude: 37.515700, longitude: 126.907722)
//
//        setRegionAndAnnotation(center: deniedCoordinate)
        
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("에러", error)
    }
    
    //ios 14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        
        checkDeviceLocationAuthorization()
    }
    
    //ios 14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}

extension MapViewController {
    
    func showActionSheet(title: [TheaterType], completehandler: @escaping (String)-> Void) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //2.버튼
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
    
        var Buttons: [UIAlertAction] = []
        
        for item in title {
            let button = UIAlertAction(title: item.rawValue, style: .default){ _ in
                
                completehandler(item.rawValue)
            }
            
            Buttons.append(button)
        }
        
        
        
//        let megaboxButton = UIAlertAction(title: TheaterType.메가박스.rawValue, style: .default){ _ in
//            
//            completehandler(TheaterType.메가박스.rawValue)
//            
//        }
        
//        let cgvButton = UIAlertAction(title: TheaterType.CGV.rawValue, style: .default){_ in
//            
//            completehandler(TheaterType.CGV.rawValue)
//        }
        
//        let lotteButton = UIAlertAction(title: TheaterType.롯데시네마.rawValue, style: .default){
//            _ in
//            
//            completehandler(TheaterType.롯데시네마.rawValue)
//        }
       
        
        let nonFilterButton = UIAlertAction(title: "전체보기", style: .default) {
            _ in
            
            self.setMap(list: self.originList)
            
        }
        
        //3.컨텐츠 + 버튼
//        alert.addAction(megaboxButton)
//        alert.addAction(cgvButton)
//        alert.addAction(lotteButton)
        
        for Button in Buttons {
            alert.addAction(Button)
        }
        
        alert.addAction(nonFilterButton)
        alert.addAction(cancelButton)
        
        //4. 띄우기
        present(alert, animated: true)
        
           
    }
}
