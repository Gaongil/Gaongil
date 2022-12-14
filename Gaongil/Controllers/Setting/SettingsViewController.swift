//
//  SettingsViewController.swift
//  Gaongil
//
//  Created by Seik Oh on 20/10/2022.


import UIKit

class SettingsViewController: UIViewController {
    
    var models = [Sections]()
    var categories = Category.categoryNames
    let coreDataManager = CoreDataManager.shared
    
    //MARK: Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.alwaysBounceVertical = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        [titleLabel, settingsTableView].forEach { view.addSubview($0) }
        navigationItem.title = "설정"
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        navigationItem.hidesBackButton = true
        SettingsTableViewCellConfigure()
        configureConstraints()
    }
    
    private func SettingsTableViewCellConfigure() {
        self.models.append(Sections(title: "Settings", options: [
            SettingsOption(title: "관심 분야 변경") {
                let selectCategoryVC = SelectCategoryViewController()
                self.navigationController?.pushViewController(selectCategoryVC, animated: true)
                selectCategoryVC.navigationItem.backBarButtonItem?.tintColor = .customSelectedGreen
                selectCategoryVC.floatingButton.isHidden = true

               
                selectCategoryVC.navigationItem.setRightBarButton(UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.tapDoneButton)), animated: true)
                selectCategoryVC.navigationController?.navigationBar.tintColor = .customSelectedGreen
                
            },
            SettingsOption(title: "개발자") {
                let developerPageVC = DeveloperPageViewController()
                self.navigationController?.pushViewController(developerPageVC, animated: true)
                developerPageVC.navigationController?.navigationBar.tintColor = .customSelectedGreen
                
            },
            SettingsOption(title: "License") {
                
            },
        ]))
    }
    
    @objc func tapDoneButton() {
        for data in categories {
            if data.isCategorySelected == true {
                coreDataManager.saveCommitteeCoreData(name: data.name, isCategorySelected: data.isCategorySelected) { _ in }
            }
        }
        
        let newViewController = SettingsViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        UserDefaults.standard.set(true, forKey: "isRegistered")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 10.64),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),

            settingsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenHeight / 30.54),
            settingsTableView.widthAnchor.constraint(equalToConstant: screenWidth),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight / 14.03
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
