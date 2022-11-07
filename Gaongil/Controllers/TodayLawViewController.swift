//
//  TodayLawViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit

class TodayLawViewController: UIViewController {
    
    private var todayLawCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth / 32.5, bottom: 0, right: screenWidth / 32.5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodayLawCollectionViewCell.self, forCellWithReuseIdentifier: TodayLawCollectionViewCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: viewDidLoad()
    // MARK: - Properties
    
    let committeeListView = CommitteeListView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "오늘의 법안"
        [todayLawCollectionView].forEach { view.addSubview($0) }
        
        todayLawCollectionView.dataSource = self
        todayLawCollectionView.delegate = self
        
        view.addSubview(committeeListView)
        
        configureConstraints()
    }
    
    // MARK: - Lifecycle
    
    private func configureConstraints() {
        
        committeeListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayLawCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            todayLawCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayLawCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayLawCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            committeeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            committeeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            committeeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            committeeListView.heightAnchor.constraint(equalToConstant: screenHeight / 15)
        ])
    }
    
    // MARK: - Helpers & fuction
    
}

extension TodayLawViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayLawCollectionViewCell.reuseIdentifier, for: indexPath) as? TodayLawCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setShadow(offset: CGSize(width: 0.3, height: 0.3), color: .lightGray, radius: 5, opacity: 0.4)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWidth = screenWidth / 1.09
        let collectionViewCellHeight = screenHeight / 7.15
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
