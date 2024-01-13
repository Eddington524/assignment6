//
//  AdViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/12.
//

import UIKit

class AdViewController: UIViewController {

    @IBOutlet var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func popButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    

}
