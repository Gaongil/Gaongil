//
//  CommitteeListView.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/04.
//

import UIKit
import CoreData

class CommitteeListView: UIView, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    let coreDataManager = CoreDataManager.shared
    var categoryList : [String] = ["전체"]
    weak var delegate: CommitteeListViewDelegate?
    var selectedCommitteeName = ""

    
    lazy var fetchedResultsController: NSFetchedResultsController<Committee> = {
        let fetchRequest: NSFetchRequest<Committee> = Committee.fetchRequest()

        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 20

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: coreDataManager.container!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private lazy var categorycollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommitteeCustomCell.self, forCellWithReuseIdentifier: "CommitteeCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(categorycollectionView)
        configureConstraints()
        do {
            try fetchedResultsController.performFetch()
            
            fetchedResultsController.fetchedObjects?.forEach { item in
                categoryList.append(item.name!)
            }
        
            categorycollectionView.reloadData()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers & fuction
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            categorycollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            categorycollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            categorycollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            categorycollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func onClickTestButton(){
        self.delegate?.onClickButton(committeeName: selectedCommitteeName)
    }
}

// MARK: - UICollectionView Setting

extension CommitteeListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth / 5.82, height: screenHeight / 24.82)
    }
    
    /// Cell 간의 top, left, bottom, right 여백에 대한 padding 을 주는 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: screenWidth / 24.38, bottom: 0, right: screenWidth / 24.38)
    }
}

extension CommitteeListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitteeCellId", for: indexPath) as! CommitteeCustomCell

        cell.backgroundColor = UIColor.customUnselectedGreen
        if indexPath.item == 0 {
            cell.configure()
            /// 다른 Cell 을 눌렀을 떄 "전체" Cell 의 seleted 를 없애기 위한 코드
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }

        cell.categoryLabel.text = categoryList[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitteeCellId", for: indexPath) as! CommitteeCustomCell
        
        print(categoryList[indexPath.row])
        
        selectedCommitteeName = CommitteeName(rawValue: categoryList[indexPath.row])?.fullName ?? String()
        print(selectedCommitteeName)
        onClickTestButton()
    
    }
}

protocol CommitteeListViewDelegate: class {
    func onClickButton(committeeName: String)
}
