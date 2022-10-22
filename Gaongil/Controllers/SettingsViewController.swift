//
//  SettingsViewController.swift
//  Gaongil
//
//  Created by Seik Oh on 20/10/2022.
//

import UIKit

struct Sections {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "설정"
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
    
    var models = [Sections]()
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        [titleLabel, settingsTableView].forEach { view.addSubview($0)}
//        title = "설정"
//        SettingstableView.frame = view.bounds
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .automatic
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        configure()
        configureConstraints()
    }
    
    private func configure() {
        self.models.append(Sections(title: "Settings", options: [
            SettingsOption(title: "관심 분야 변경") {
                
            },
            SettingsOption(title: "개발자") {
                
            },
            SettingsOption(title: "개인정보 처리방침") {
                
            },
            SettingsOption(title: "License") {
                
            },
        ]))
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
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
