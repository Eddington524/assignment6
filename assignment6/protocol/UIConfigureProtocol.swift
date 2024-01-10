//
//  UIConfigureProtocol.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/11.
//

import UIKit

protocol UIConfigureProtocol{
    var id: String { get set }
    func designLayout() -> UICollectionViewFlowLayout
}
