//
//  MainViewController.swift
//  AlefTest
//
//  Created by Филипп Гурин on 27.07.2021.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    
    private var tableView: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
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
        
        [tableView,addButton].forEach {
            view.addSubview($0)
        }
        setupTableView()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
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
        tableView.keyboardDismissMode = .onDrag
        setInsetForButton()
        
        
        
      //  tableView.tableHeaderView = DeleteView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    private func setInsetForButton() {
        tableView.contentInset.bottom = 50
    }
    
    private func setInsetWithoutButton() {
        tableView.contentInset.bottom = 0
    }
    
    private func setInsetWithKeyboard() {
        tableView.contentInset.bottom = 370
    }
    
    @objc private func addButtonTapped() {
        persons.append(Person())
        if tableView.numberOfSections <= 6 {
            tableView.reloadData()
        }
        if tableView.numberOfSections == 6 {
            addButton.isHidden = true
            setInsetWithoutButton()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if addButton.isHidden {
            setInsetWithoutButton()
        } else {
            setInsetForButton()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return DeleteView(frame: CGRect(), needsDeleteButton: false)
        }
        return DeleteView(frame: CGRect(), needsDeleteButton: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
        setInsetForButton()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension MainViewController: PersonDelegate {
    
    func scroll(to row: PersonCell) {
        guard let newIndexPath = tableView.indexPath(for: row) else {
            return
        }
        guard newIndexPath.section != 0 else {
            return
        }
        if newIndexPath.section + 1 == persons.count {
            setInsetWithKeyboard()
        }
        tableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
    }
    
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}






