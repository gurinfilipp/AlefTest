//
//  MainViewController.swift
//  AlefTest
//
//  Created by Филипп Гурин on 27.07.2021.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    
    private let tableView: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
    
    private var persons: [Person] = []
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить данные о ребенке", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize(width: 3, height: 2)
        button.layer.shadowOpacity = 10
        button.tintColor = .black
        return button
    }()
    
    var numberOfSections: Int = 1
  //  var numberOfRowsInSection: Int = 5
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        persons.append(Person())
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.tableView.addGestureRecognizer(tapGesture)
        self.tableView.tableHeaderView?.addGestureRecognizer(tapGesture)
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        title = "Введите данные о семье"
        setupTableView()
        view.backgroundColor = .orange
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(PersonCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    @objc private func addButtonTapped() {
        print("wow")
        persons.append(Person())
        if tableView.numberOfSections <= 6 {
            self.numberOfSections += 1
            tableView.reloadData()
            if tableView.numberOfSections == 6 {
                addButton.isHidden = true
            }
        } else {
            print("too manu children")
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        [view, tableView].forEach {
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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PersonCell else {
            return .init()
        }
        
        cell.configure(with: persons[indexPath.section])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Введите ваши данные"
        default: return "Введите данные ребенка"
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            persons.remove(at: indexPath.section)
        default:
            fatalError()
        }
        tableView.reloadData()
        addButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
}

extension MainViewController: PersonDelegate {
    
    // !!!!!! У МЕНЯ ДВЕ СЕКЦИИ! ЗНАЧИТ НАВерное НАДО СДЕЛАТЬ 2 МАССИВА!!!!
    
    
    
    func report(text: String, in cell: UITableViewCell, field: String) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        switch field {
        case "Имя": persons[indexPath.section].firstName = text
        case "Фамилия": persons[indexPath.section].lastName = text
        case "Отчество": persons[indexPath.section].patronymic = text
        case "Возраст": persons[indexPath.section].age = text
        default: fatalError()
        }
        print("shit its report func")
        
    }
    
}

protocol PersonDelegate: AnyObject {
    func report(text: String, in: UITableViewCell, field: String)
}




