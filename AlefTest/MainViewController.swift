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
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        
        return tableView
    }()
    
    
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить данные о ребенке", for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.red.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize(width: 3, height: 2)
        button.layer.shadowOpacity = 10
        button.tintColor = .black
        return button
    }()
    
    var numberOfSections: Int = 1
    var numberOfRowsInSection: Int = 5
    
    var firstNameCell: UITableViewCell = UITableViewCell()
    var lastNameCell: UITableViewCell = UITableViewCell()
    var patronymicCell: UITableViewCell = UITableViewCell()
    var ageCell: UITableViewCell = UITableViewCell()
    var addChildCell: UITableViewCell = UITableViewCell()
    
    var firstNameTextField: UITextField = UITextField()
    var lastNameTextField: UITextField = UITextField()
    var patronymicTextField: UITextField = UITextField()
    var ageTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        title = "Введите данные о семье"
        setupTableView()
        view.backgroundColor = .orange
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
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
        
        self.addChildCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.addChildCell.textLabel?.text = "+ Добавить ребенка"
        //ageTextField.backgroundColor = .red
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    @objc private func addButtonTapped() {
        print("wow")
        self.numberOfSections += 1
        tableView.reloadData()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        [firstNameTextField, lastNameTextField, ageTextField, patronymicTextField].forEach {
            $0.resignFirstResponder()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
        addButton.pin.horizontally(30).bottom(30).height(60)
    }
    
    
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var cell: UITableViewCell?
        if indexPath.row == 0 {
            cell = self.lastNameCell
        } else if indexPath.row == 1 {
            cell = self.firstNameCell
        } else if indexPath.row == 2 {
            cell = self.patronymicCell
        } else if indexPath.row == 3 {
            cell = self.ageCell
        } else {
            cell = UITableViewCell()
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Введите ваши данные"
        default: return "Введите данные ребенка"
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("will display cell \(indexPath)")
    }
    
}
