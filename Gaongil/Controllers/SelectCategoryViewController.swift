//
//  SelectCategoryViewController.swift
//  Gaongil
//
//  Created by Lena on 2022/10/15.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let categories = Category.categoryNames
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "어떤 분야에 관심이 있나요?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "3가지 이상 분야를 선택해주세요"
        label.textColor = UIColor.customSelectedGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var floatingButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customSelectedGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: selectCategoryCollectionView
    
    private var selectCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = UIScreen.main.bounds.width / 19.5
        layout.minimumLineSpacing = UIScreen.main.bounds.width / 19.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SelectCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SelectCategoryCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.customLightGray
        [titleLabel, subTitleLabel, selectCategoryCollectionView].forEach { view.addSubview($0)}
        
        selectCategoryCollectionView.dataSource = self
        selectCategoryCollectionView.delegate = self
        view.addSubview(floatingButton)
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 10.64),
            
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            selectCategoryCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectCategoryCollectionView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: screenHeight / 16.54),
            selectCategoryCollectionView.bottomAnchor.constraint(equalTo: floatingButton.topAnchor, constant: 0),
            selectCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 18.57),
            selectCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 18.57),
            
            floatingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            floatingButton.widthAnchor.constraint(equalToConstant: screenWidth / 1.13),
            floatingButton.heightAnchor.constraint(equalToConstant: screenHeight / 13.19),
            floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenHeight / 30.14)
        ])
    }
}

extension SelectCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? SelectCategoryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .white
        cell.categoryLabel.text = categories[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let anchorSpacing = (screenWidth / 18.57) * 2
        let insetSpacing = (screenWidth / 19.5) * 2
        let collectionViewCellWidth = screenWidth - anchorSpacing - insetSpacing
        return CGSize(width: collectionViewCellWidth / 3, height: collectionViewCellWidth / 3)
    }
}
