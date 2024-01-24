//
//  UIViewController + Extension.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/25.
//

import UIKit

extension UIViewController {
    func showLocationAlert(title: String, message: String, buttonTitle: String, completehandler: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completehandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    
    }
}
