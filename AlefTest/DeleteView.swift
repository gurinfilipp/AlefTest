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
        return button
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    init(frame: CGRect, needsDeleteButton: Bool, section: Int?) {
        super.init(frame: frame)

        if needsDeleteButton {
            self.addSubview(deleteButton)
            guard let childNumber = section else {
                return
            }
            label.text = "Инфа \(childNumber)-го ребенка"
        } else {
            label.text = "Инфа моя"
        }
        addSubview(label)
   
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.pin.vertically().left(15).sizeToFit(.height)
        deleteButton.pin.vertically().right(15).width(60)
    }
    
    @objc func deleteButtonTapped() {
        print(#function)
    }
    
}
