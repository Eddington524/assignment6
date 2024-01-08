//
//  shoppingViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/06.
//

import UIKit

struct Todo {
    var list: String
    var isDone: Bool
    var isFavorit: Bool
}

class ShoppingViewController: UITableViewController {
    
    var TodoList: [Todo] = [Todo(list: "그립톡 구매하기", isDone: false, isFavorit: false),
         Todo(list: "사이다 구매", isDone: false, isFavorit: false),
         Todo(list: "아이패드 케이스 최저가 알아보기", isDone: false, isFavorit: false),
         Todo(list: "양말", isDone: false, isFavorit: false)]
    
//    var list = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var headerBox: UIView!
    
    @IBOutlet var headerTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle.text = "쇼핑"
        headerBox.layer.cornerRadius = 10
    }
    
    //1. 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return list.count
        return TodoList.count
    }
    
    //2. 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as! ShoppingTableViewCell
        
//        cell.listLabel.text = list[indexPath.row]
        cell.listLabel.text = TodoList[indexPath.row].list
        
//        cell.checkboxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
//        
        cell.favoritButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        cell.boxView.backgroundColor = .systemGray5
        
        cell.boxView.layer.cornerRadius = 10
        
        // 이미지를 todo bool 상태에 따라 업데이트
        let leftImageName = TodoList[indexPath.row].isDone ? "checkmark.circle.fill" : "checkmark.circle"
        
        cell.checkboxButton.setImage(UIImage(systemName: leftImageName), for: .normal)
        
        let rightImageName = TodoList[indexPath.row].isFavorit ? "star.fill" : "star"
        
        cell.favoritButton.setImage(UIImage(systemName: rightImageName), for: .normal)
        
        // 각 셀의 버튼에 tag 달기
        cell.checkboxButton.tag = indexPath.row
        cell.favoritButton.tag = indexPath.row
        
        //각 액션 연결
        cell.checkboxButton.addTarget(self, action: #selector(checkboxClicked), for: .touchUpInside)
        
        cell.favoritButton.addTarget(self, action: #selector(favoritButtonClicked), for: .touchUpInside)
        
        return cell
    }

    // 버튼 클릭 메서드
    @objc func checkboxClicked(sender: UIButton) {
        TodoList[sender.tag].isDone.toggle()
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section:0)], with: .automatic)
        
    }
    
    
    @objc func favoritButtonClicked(sender: UIButton) {
        TodoList[sender.tag].isFavorit.toggle()
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section:0)], with: .automatic)
    }
    
    //3. 셀 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
//            list.remove(at: indexPath.row)
            TodoList.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
    @IBAction func textFieldReturn(_ sender: UITextField) {
        
        appendList()
    }
    
    @IBAction func onAddButtonClicked(_ sender: UIButton) {
        
        appendList()
        
    }
    
    func appendList(){
        
        if textField.text?.trimmingCharacters(in: .whitespaces) == ""
        {
            return
        }
        
//        list.append(textField.text!)
        TodoList.append(Todo(list: textField.text!, isDone: false, isFavorit: false))
        
        tableView.reloadData()
        textField.text = ""
    }
}
