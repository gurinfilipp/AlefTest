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
    
    private var persons: [Person] = [Person()]
    private var numberOfSections: Int = 1
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить данные о ребенке", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.addShadow()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Введите данные о семье"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.tableView.addGestureRecognizer(tapGesture)
        self.tableView.tableHeaderView?.addGestureRecognizer(tapGesture)
        
        [tableView,addButton].forEach {
            view.addSubview($0)
        }
        setupTableView()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
        addButton.pin.horizontally(30).bottom(30).height(60)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(PersonCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    @objc private func addButtonTapped() {
        persons.append(Person())
        if tableView.numberOfSections <= 6 {
            tableView.reloadData()
        }
        if tableView.numberOfSections == 6 {
            addButton.isHidden = true
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        [view, tableView].forEach {
            $0.resignFirstResponder()
        }
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
        default: return "Введите данные \(section)-го ребенка"
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
        if editingStyle == .delete {
            persons.remove(at: indexPath.section)
        }
        tableView.reloadData()
        addButton.isHidden = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
}

extension MainViewController: PersonDelegate {
    
    func report(text: String, in cell: UITableViewCell, field: String) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        switch field {
        case "Имя": persons[indexPath.section].firstName = text
        case "Фамилия": persons[indexPath.section].lastName = text
        case "Отчество": persons[indexPath.section].patronymic = text
        case "Возраст": persons[indexPath.section].age = text
        default: return
        }
    }
}






