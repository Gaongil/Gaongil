//
//  FavoriteDetailViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/11.
//

import UIKit
import CoreData

class FavoriteDetailViewController: UIViewController {
    
    var instituteView = CustomView()
    var progressView = CustomView()
    var suggestionDateView = CustomView()
    var proposerView = CustomView()
    
    var shared = ResponseManager.shared
    let coreDataManager = CoreDataManager.shared
    var result = [NSManagedObject]()
    var selectedIndex = 0
    
//    var favoriteLawIsSelected : Bool = false{
//        willSet {
//            self.setSelected(newValue)
//        }
//    }
    
    
    private var lawTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }

    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        let subviews = [instituteView, progressView, suggestionDateView, proposerView]
        
        instituteView.updateSubTitleLabel("소관기관")
        progressView.updateSubTitleLabel("진행사항")
        suggestionDateView.updateSubTitleLabel("제안일")
        proposerView.updateSubTitleLabel("제안자")
        
        for view in subviews {
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
        
    }()
    
    private var contentTextView: UITextView = {
        let textView = UITextView()
    
        textView.isScrollEnabled = true
        textView.textColor = .customBlack
        textView.font = .systemFont(ofSize: 19, weight: .regular)
        textView.text = ""
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    @objc func favoriteLaw() {
        
        let lawTitle = lawTitleLabel.text ?? String()
        let institute = instituteView.contentLabel.text ?? String()
        let progress = progressView.contentLabel.text ?? String()
        let proposer = proposerView.contentLabel.text ?? String()
        let suggestionDate = suggestionDateView.contentLabel.text ?? String()
        let contentText = contentTextView.text ?? String()
        
        coreDataManager.saveFavoriteCoreData(lawTitle: lawTitle, institute: institute, progress: progress, proposer: proposer, suggestionDate: suggestionDate, contentText: contentText) { _ in }
        
//        if favoriteLawIsSelected {
//            favoriteLawIsSelected = false
//            print(favoriteLawIsSelected)
//        } else {
//            favoriteLawIsSelected = true
//            print(favoriteLawIsSelected)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        
        self.navigationItem.title = "법안 상세내용"
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"star"), style: .plain, target: self, action: #selector(favoriteLaw))
        self.navigationController?.navigationBar.tintColor = .customSelectedGreen
        
        [lawTitleLabel, cardView, contentTextView].forEach { view.addSubview($0) }
        cardView.addSubview(informationStackView)
        
        configureConstraints()
        cardView.setShadow(offset: CGSize.init(width: 1, height: 1),
                           color: UIColor.black,
                           radius: 6,
                           opacity: 0.2)
        
        lawTitleLabel.text = result[selectedIndex].value(forKey: "lawTitle") as? String
            instituteView.contentLabel.text = result[selectedIndex].value(forKey: "institute") as? String
            progressView.contentLabel.text = result[selectedIndex].value(forKey: "progress") as? String
            proposerView.contentLabel.text = result[selectedIndex].value(forKey: "proposer") as? String
            suggestionDateView.contentLabel.text = result[selectedIndex].value(forKey: "suggestionDate") as? String
            contentTextView.text = result[selectedIndex].value(forKey: "contentText") as? String
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lawTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            lawTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenHeight / 30.145),
            
            cardView.topAnchor.constraint(equalTo: lawTitleLabel.bottomAnchor, constant: screenHeight / 25.09),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.heightAnchor.constraint(equalToConstant: screenHeight / 6.58),
            
            informationStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: screenWidth / 25.94),
            informationStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -screenWidth / 22.94),
            informationStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            informationStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5),
            
            contentTextView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: screenHeight / 26.09),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 22.94),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
