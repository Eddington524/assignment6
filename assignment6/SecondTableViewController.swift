//
//  SecondTableViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/06.
//

import UIKit

class SecondTableViewController: UITableViewController {

    let titleArr = ["전체설정", "개인설정", "기타"]
    
    let entireSettings = ["공지사항", "실험실", "버전정보"]
    
    let personSettings = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    @IBOutlet var headerTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle.text = "설정"
        headerTitle.font = .boldSystemFont(ofSize: 20)
    }
// 1. 섹션 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
// 2. 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return entireSettings.count
        }else if section == 1{
            return personSettings.count
        }else {
            return 1
        }
    }
    
// 2. 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "entireSetCell", for: indexPath)
     
        let sectionIdx = indexPath.section
        
        if sectionIdx == 0 {
            cell.textLabel?.text = entireSettings[indexPath.row]
        } else if sectionIdx == 1 {
            cell.textLabel?.text = personSettings[indexPath.row]
        } else{
            cell.textLabel?.text = "고객센터/도움말"
        }
        
        return cell
    }
// 3. 셀 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // 섹션 타이틀
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return titleArr[section]
    }
}
