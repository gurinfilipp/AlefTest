//
//  MainViewController.swift
//  AlefTest
//
//  Created by Филипп Гурин on 27.07.2021.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
        
        
        return tableView
    }()
    
    var firstNameCell: UITableViewCell = UITableViewCell()
    var lastNameCell: UITableViewCell = UITableViewCell()
    var patronymicCell: UITableViewCell = UITableViewCell()
    var ageCell: UITableViewCell = UITableViewCell()
    
    var firstNameTextField: UITextField = UITextField()
    var lastNameTextField: UITextField = UITextField()
    var patronymicTextField: UITextField = UITextField()
    var ageTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "Введите данные о семье"
        setupTableView()
        
        self.lastNameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.lastNameTextField = UITextField(frame: CGRect(x: 15, y: 0, width: self.lastNameCell.contentView.bounds.width, height: 50))
        self.lastNameTextField.placeholder = "Фамилия"
        self.lastNameCell.addSubview(self.lastNameTextField)
        
        self.firstNameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.firstNameTextField = UITextField(frame: CGRect(x: 15, y: 0, width: self.firstNameCell.contentView.bounds.width, height: 50))
        self.firstNameTextField.placeholder = "Имя"
        self.firstNameCell.addSubview(self.firstNameTextField)
        
        self.patronymicCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.patronymicTextField = UITextField(frame: CGRect(x: 15, y: 0, width: self.patronymicCell.contentView.bounds.width, height: 50))
        self.patronymicTextField.placeholder = "Отчество"
        self.patronymicCell.addSubview(self.patronymicTextField)
        
        
        self.ageCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.ageTextField = UITextField(frame: CGRect(x: 15, y: 0, width: self.ageCell.contentView.bounds.width, height: 50))
        self.ageTextField.placeholder = "Возраст"
        ageTextField.keyboardType = .numberPad
        ageTextField.textContentType = .telephoneNumber
        self.ageCell.addSubview(self.ageTextField)
        
        
        //ageTextField.backgroundColor = .red
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemGroupedBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
    }
    
    
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.lastNameCell
            case 1: return self.firstNameCell
            case 2: return self.patronymicCell
            case 3: return self.ageCell
            default: fatalError("Unknown row in section 0")
            }
            
        default: fatalError("Unknown section")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Введите Ваши данные"
    }
    
    
    
}
