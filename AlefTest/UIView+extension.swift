//
//  UIView+extension.swift
//  AlefTest
//
//  Created by Филипп Гурин on 28.07.2021.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 3, height: 2)
        layer.shadowOpacity = 10
    }
}
