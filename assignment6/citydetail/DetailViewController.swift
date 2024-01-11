//
//  DetailViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/11.
//

import UIKit

let allTravel :[Travel] = TravelInfo().travel

class DetailViewController: UIViewController {

    @IBOutlet var DetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailTableView.backgroundColor = .clear
        configureTableView()
        
    }
    
}

extension DetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    // xib register
    func configureTableView() {
 
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
        
        let xib = UINib(nibName: DetailTableViewCell.identifier, bundle: nil)
        
        DetailTableView.register(xib, forCellReuseIdentifier: DetailTableViewCell.identifier)

        let xib2 = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        
        //2. register
        DetailTableView.register(xib2, forCellReuseIdentifier: AdTableViewCell.identifier)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTravel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !allTravel[indexPath.row].ad {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            
            
            let travel = allTravel[indexPath.row]
            
            cell.spotNameLabel.text = travel.title
            
            cell.subLabel.text = travel.description
            
            let url = URL(string: travel.travel_image!)!
            
            cell.thumnailImageView.kf.setImage(with: url)
            
            cell.gradeLabel.text = "\(travel.grade ?? 0 )"
            
            cell.saveLabel.text = "\(travel.save ?? 0 )"
            
           
            let heart = travel.like ?? false ? UIImage(systemName: "heart.fill") :
            UIImage(systemName: "heart")
            
            cell.likeButton.setImage(heart, for: .normal)
            
            return cell
            
        }else{
            
            let travel = allTravel[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            
            cell.adLabel.text = travel.title
            cell.adView.backgroundColor = RandomColor()

            return cell
        }
        
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !allTravel[indexPath.row].ad {
            return 170
        }else{
            return 80
        }
    }
    
}

extension DetailViewController {
    func RandomColor() -> UIColor {
            let red = CGFloat.random(in: 0...1)
            let green = CGFloat.random(in: 0...1)
            let blue = CGFloat.random(in: 0...1)
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            return color
        }

}

extension DetailViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if allTravel[indexPath.row].ad {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdViewController") as! AdViewController
            
//            let nav = UINavigationController(rootViewController: vc)
//            
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SpotViewController") as! SpotViewController
            
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true)
        }
    }
}
