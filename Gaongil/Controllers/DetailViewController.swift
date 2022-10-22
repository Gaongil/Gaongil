//
//  DetailViewController.swift
//  Gaongil
//
//  Created by Lena on 2022/10/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var instituteView = CustomView()
    var progressView = CustomView()
    var suggestionDateView = CustomView()
    var proposerView = CustomView()
    
    private var lawTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "3차 병원에 대한 개정법률안"
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
        
        instituteView.updateContentLabel("보건복지부")
        progressView.updateContentLabel("접수")
        suggestionDateView.updateContentLabel("2022-03-01")
        proposerView.updateContentLabel("김땡땡")
        
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
        textView.text = "여기에는 디테일한 법안 내용이 들어갑니다.여기에는 디테일한 법안 내용이 들어갑니다. 여기에는 디테일한 법안 내용이 들어갑니다. 여기에는 디테일한 법안 내용이 들어갑니다. \n여기에는 디테일한 법안 내용이 들어갑니다. \n여기에는 디테일한 법안 내용이 들어갑니다."

        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        
        [lawTitleLabel, cardView, contentTextView].forEach { view.addSubview($0) }
        cardView.addSubview(informationStackView)
        
        configureConstraints()
        cardView.setShadow(offset: CGSize.init(width: 1, height: 1),
                           color: UIColor.black,
                           radius: 6,
                           opacity: 0.2)
    }
    
    func viewWillAppear() {
        super.viewWillAppear(true)
        
        navigationController?.title = "법안 상세내용"
        navigationController?.isNavigationBarHidden = false
        
        // TODO: star toggle 구현하기
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), menu: .none)
        navigationController?.navigationItem.backButtonTitle = ""
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lawTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            lawTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 20.09 + 30),
            
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
