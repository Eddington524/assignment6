//
//  shoppingViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/06.
//

import UIKit

class ShoppingViewController: UITableViewController {
    
    var list = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var headerBox: UIView!
    
    @IBOutlet var headerTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle.text = "쇼핑"
        headerBox.layer.cornerRadius = 10
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.listLabel.text = list[indexPath.row]
        
        cell.checkboxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
        cell.favoritButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        cell.boxView.backgroundColor = .systemGray5
        
        cell.boxView.layer.cornerRadius = 10
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            list.remove(at: indexPath.row)
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
        
        list.append(textField.text!)
        tableView.reloadData()
        textField.text = ""
    }
}
