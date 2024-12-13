//
//  TodayLawViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit

class TodayLawViewController: UIViewController, CommitteeListViewDelegate {
    
    // MARK: - Properties
    
    let committeeListView = CommitteeListView()
    var shared = ResponseManager.shared
    var result = [Row]()
    
    private var todayLawCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: screenWidth / 32.5, bottom: 0, right: screenWidth / 32.5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodayLawCollectionViewCell.self, forCellWithReuseIdentifier: TodayLawCollectionViewCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.topItem?.title = "오늘의 법안"

        [todayLawCollectionView, committeeListView].forEach { view.addSubview($0) }
        
        todayLawCollectionView.dataSource = self
        todayLawCollectionView.delegate = self

        committeeListView.delegate = self
        
        configureConstraints()
        
        shared.fetchLawData(name: "") { result in
            self.result = result[0]

            DispatchQueue.main.async {
                self.todayLawCollectionView.reloadData()
            }
        }
        
    }
    
    func viewWillAppear() {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureConstraints() {
        
        committeeListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayLawCollectionView.topAnchor.constraint(equalTo: committeeListView.bottomAnchor),
            todayLawCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayLawCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayLawCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            committeeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            committeeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            committeeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            committeeListView.heightAnchor.constraint(equalToConstant: screenHeight / 15)
        ])
    }
    
    // MARK: - Helpers & fuction
    
    func onClickButton(committeeName: String){
        shared.fetchLawData(name: committeeName) { result in
            self.result = result[0]

            DispatchQueue.main.async {
                self.todayLawCollectionView.reloadData()
            }
        }
    }
}

extension TodayLawViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayLawCollectionViewCell.reuseIdentifier, for: indexPath) as? TodayLawCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setShadow(offset: CGSize(width: 0.3, height: 0.3), color: .lightGray, radius: 5, opacity: 0.4)
        
        let results = result[indexPath.row]
        
        cell.titleLabel.text = results.billName
        cell.committeeLabel.text = (results.proposeDt?.formattedDateString() ?? "") + " " + (results.currCommittee ?? "")
        cell.statusLabel.text = results.procResultCd
        
        if results.procResultCd == "원안가결" {
            cell.circleView.backgroundColor = .customSelectedGreen
        } else if results.procResultCd == "수정가결" {
            cell.circleView.backgroundColor = .systemOrange
        } else {
            cell.circleView.backgroundColor = .systemRed
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWidth = screenWidth / 1.09
        let collectionViewCellHeight = screenHeight / 7.15
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        
        detailViewController.result = result
        detailViewController.selectedIndex = indexPath.row
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
