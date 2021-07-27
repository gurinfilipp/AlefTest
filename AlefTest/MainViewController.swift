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
    
    var persons: [Person] = [Person(firstName: "fds", lastName: "sdf", patronymic: "qe", age: 12)] {
        didSet {
            print("persons is chaging \(persons)")
            print(persons.count)
        }
    }
    
    func report(text: String, in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        print("shit its report func")
        persons[indexPath.section].firstName = text
    }
    
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
    var numberOfRowsInSection: Int = 5
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if numberOfSections <= 6 {
        self.numberOfSections += 1
        tableView.reloadData()
            if numberOfSections == 6 {
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
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("will display cell \(indexPath)")
    }
    
}

extension MainViewController: PersonDelegate {
    func personDataChanged(for row: Int, with newValue: String, in field: String) {
        
        switch field {
        case "firstName":
            self.persons[row].firstName = newValue
        case "lastName":
            self.persons[row].lastName = newValue
        case "patronymic":
            self.persons[row].patronymic = newValue
        case "age":
            self.persons[row].age = Int(newValue)
        default:
            break
        }
        
        print("hi i am mvc")
        tableView.reloadData()
    }
    
    
    
}

protocol PersonDelegate: AnyObject {
    func report(text: String, in: UITableViewCell)
}



final class PersonCell: UITableViewCell {
    
    var delegate: PersonDelegate? = MainViewController()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        [firstNameTextField, lastNameTextField, patronymicTextField, ageTextField].forEach {
            contentView.addSubview($0)
        }
//        firstNameTextField.addTarget(self, action: #selector(updateFirstName), for: .editingChanged)
//        lastNameTextField.addTarget(self, action: #selector(updatelastName), for: .editingChanged)
//        patronymicTextField.addTarget(self, action: #selector(updatePatronymic), for: .editingChanged)
//        ageTextField.addTarget(self, action: #selector(updateAge), for: .editingChanged)
        
        firstNameTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.contentView.addGestureRecognizer(tapGesture)
        self.superview?.addGestureRecognizer(tapGesture)
        self.superview?.superview?.addGestureRecognizer(tapGesture)
    }
    
//    @objc func updateFirstName() {
//        let newValue = self.firstNameTextField.text
//        delegate?.personDataChanged(for: 0, with: newValue!, in: "firstName")
//    }
//    @objc func updatelastName() {
//        let newValue = self.lastNameTextField.text
//        delegate?.personDataChanged(for: 0, with: newValue!, in: "lastName")
//    }
//    @objc func updatePatronymic() {
//        let newValue = self.patronymicTextField.text
//        delegate?.personDataChanged(for: 0, with: newValue!, in: "patronymic")
//    }
//    @objc func updateAge() {
//        let newValue = self.ageTextField.text
//        delegate?.personDataChanged(for: 0, with: newValue!, in: "age")
//    }
    
    private var firstNameTextField: UITextField = {
    let TF = UITextField()
        TF.placeholder = "Имя"
    return TF
    }()
    
    
    private var lastNameTextField: UITextField = {
        let TF = UITextField()
            
            TF.placeholder = "Фамилия"
        return TF
        }()
    private var patronymicTextField: UITextField = {
        let TF = UITextField()
            
            TF.placeholder = "Отчество"
        return TF
        }()
    private var ageTextField: UITextField = {
        let TF = UITextField()
            TF.keyboardType = .numberPad
            TF.placeholder = "Возраст"
        return TF
        }()
    
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
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        [firstNameTextField, lastNameTextField, ageTextField, patronymicTextField].forEach {
            $0.resignFirstResponder()
        }
        
    }
    
    func configure(with person: Person) {
        self.firstNameTextField.text = person.firstName
        self.lastNameTextField.text = person.lastName
        self.patronymicTextField.text = person.patronymic
        guard let ageString = person.age else { return }
        
        self.ageTextField.text = "\(ageString)"
    }
    
    
}

extension PersonCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.report(text: textField.text ?? "", in: self)
    }
}

