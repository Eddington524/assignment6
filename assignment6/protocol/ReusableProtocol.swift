//
//  ReusableProtocol.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/15.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String {get}
}

extension UIViewController: ReusableProtocol{
    
    static var identifier: String{
        return String(describing: self)
    }
    
}
