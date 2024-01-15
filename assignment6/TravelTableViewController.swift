//
//  TravelViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/08.
//

import UIKit
import Kingfisher

class TravelTableViewController: UITableViewController {

    @IBOutlet var HeaderView: UIView!
    @IBOutlet var headerTitle: UILabel!
    
    let list: [Magazine] = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle.text = "SeSAC TRAVEL"
        
        tableView.rowHeight = 500
    }

    //1. 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    //2. 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelViewCell", for: indexPath) as! TravelTableViewCell
        
        let mainTitle = list[indexPath.row].title
        let link = list[indexPath.row].photo_image
        let subTitle = list[indexPath.row].subtitle
        let dateText = list[indexPath.row].date
        
        let url = URL(string: link)
        
        cell.thumnailImage.kf.setImage(with: url)
        cell.thumnailImage.layer.cornerRadius = 10
        
        cell.mainTitle.text = mainTitle
        cell.mainTitle.font = .systemFont(ofSize: 20)
        
        cell.subTitleLabel.text = subTitle
        cell.subTitleLabel.textColor = .gray
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        if let date = dateFormatter.date(from: list[indexPath.row].date){
            
            let newDateFomatter = DateFormatter()
            newDateFomatter.dateFormat = "yy년 MM월 dd일"
            let formattedDate = newDateFomatter.string(from: date)
            
            cell.dateLabel.text = formattedDate
        }else{
            print("날짜 변환 실패")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(list[indexPath.row].link)
//        
        print(indexPath.row)

        let vc = storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
    
        let nav = UINavigationController(rootViewController: vc)
 
        vc.urlStr = list[indexPath.row].link
        print(nav)
        print(vc)
        
        navigationController?.pushViewController(vc, animated: true)
    }

}
