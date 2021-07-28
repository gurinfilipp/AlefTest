//
//  DeleteView.swift
//  AlefTest
//
//  Created by Филипп Гурин on 28.07.2021.
//

import UIKit
import PinLayout

class DeleteView: UIView {
    
    var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    var label: UILabel = UILabel()
    
    
    
    
    init(frame: CGRect, needsDeleteButton: Bool) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        if needsDeleteButton {
            self.addSubview(deleteButton)
            label.text = "Инфа ребенка"
        } else {
            label.text = "Инфа моя"
        }
        addSubview(label)
        label.backgroundColor = .red
        label.textAlignment = .center
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.pin.vertically().left(15).sizeToFit(.height)
        deleteButton.pin.vertically().right(15).width(60)
        
    }
    
}
