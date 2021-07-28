//
//  PersonCell.swift
//  AlefTest
//
//  Created by Филипп Гурин on 28.07.2021.
//

import UIKit

protocol PersonDelegate: AnyObject {
    func report(text: String, in: UITableViewCell, field: String)
}

final class PersonCell: UITableViewCell {
    
    weak var delegate: PersonDelegate?
    
    private var firstNameTextField: UITextField = UITextField()
    private var lastNameTextField: UITextField = UITextField()
    private var patronymicTextField: UITextField = UITextField()
    private var ageTextField: UITextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [firstNameTextField, lastNameTextField, patronymicTextField, ageTextField].forEach {
            contentView.addSubview($0)
            $0.delegate = self
        }
        configureTextFields()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.contentView.addGestureRecognizer(tapGesture)
        self.superview?.addGestureRecognizer(tapGesture)
        self.superview?.superview?.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstNameTextField.pin.horizontally(15).top(20).height(40)
        lastNameTextField.pin.horizontally(15).below(of: firstNameTextField).marginTop(20).height(40)
        patronymicTextField.pin.horizontally(15).below(of: lastNameTextField).marginTop(20).height(40)
        ageTextField.pin.horizontally(15).below(of: patronymicTextField).marginTop(20).height(40)
    }
    
    private func configureTextFields() {
        firstNameTextField.placeholder = "Имя"
        lastNameTextField.placeholder = "Фамилия"
        patronymicTextField.placeholder = "Отчество"
        ageTextField.placeholder = "Возраст"
        ageTextField.keyboardType = .numbersAndPunctuation
    }
    
    func configure(with person: Person) {
        self.firstNameTextField.text = person.firstName
        self.lastNameTextField.text = person.lastName
        self.patronymicTextField.text = person.patronymic
        self.ageTextField.text = person.age
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        [firstNameTextField, lastNameTextField, ageTextField, patronymicTextField].forEach {
            $0.resignFirstResponder()
        }
    }
}

extension PersonCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldText = textField.text else {
            return
        }
        delegate?.report(text: textFieldText, in: self, field: textField.placeholder ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
