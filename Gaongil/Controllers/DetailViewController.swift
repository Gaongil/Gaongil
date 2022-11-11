//
//  DetailViewController.swift
//  Gaongil
//
//  Created by Lena on 2022/10/18.
//

import UIKit
import SafariServices


class DetailViewController: UIViewController {
    
    var instituteView = CustomView()
    var progressView = CustomView()
    var suggestionDateView = CustomView()
    var proposerView = CustomView()
    
    var shared = ResponseManager.shared
    let coreDataManager = CoreDataManager.shared
    var result = [Row]()
    var selectedIndex = 0
    var detailLawLink = NSURL(string: "")
    
    
//    var favoriteLawIsSelected : Bool = false{
//        willSet {
//            self.setSelected(newValue)
//        }
//    }
    
    
    private var lawTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        label.numberOfLines = 0
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
        stackView.distribution = .equalCentering
        stackView.spacing = 3
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
        
    }()
    
    private var contentTextView: UITextView = {
        let textView = UITextView()
    
        textView.isScrollEnabled = true
        textView.textColor = .customBlack
        textView.font = .systemFont(ofSize: 19, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private var lawUrlButton: UIButton = {
        let button = UIButton()
        button.setTitle("웹에서 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customSelectedGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(lawUrlButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func favoriteLaw() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"star.fill"), style: .done, target: self, action: nil)
        
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

    @objc func lawUrlButtonTapped() {
        let detailLawSafariView: SFSafariViewController = SFSafariViewController(url: detailLawLink! as URL)
        self.present(detailLawSafariView, animated: true)
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
        contentTextView.addSubview(lawUrlButton)
        
        configureConstraints()
        cardView.setShadow(offset: CGSize.init(width: 1, height: 1),
                           color: UIColor.black,
                           radius: 6,
                           opacity: 0.2)
        
        lawTitleLabel.text = shared.rows[0][selectedIndex].billName ?? String()
        instituteView.contentLabel.text = shared.rows[0][selectedIndex].currCommittee ?? String()
        progressView.contentLabel.text = shared.rows[0][selectedIndex].procResultCd ?? String()
        proposerView.contentLabel.text = shared.rows[0][selectedIndex].proposer ?? String()
        suggestionDateView.contentLabel.text = shared.rows[0][selectedIndex].proposeDt ?? String()
        detailLawLink = NSURL(string: self.shared.rows[0][selectedIndex].linkUrl ?? String())
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lawTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            lawTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenHeight / 30.145),
            lawTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 22.94),
            
            cardView.topAnchor.constraint(equalTo: lawTitleLabel.bottomAnchor, constant: screenHeight / 25.09),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.heightAnchor.constraint(equalToConstant: screenHeight / 4),
            
            informationStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            informationStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            informationStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            informationStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: screenHeight / 26.09),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 22.94),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            lawUrlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lawUrlButton.widthAnchor.constraint(equalToConstant: screenWidth / 1.13),
            lawUrlButton.heightAnchor.constraint(equalToConstant: screenHeight / 13.19),
            lawUrlButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
}
