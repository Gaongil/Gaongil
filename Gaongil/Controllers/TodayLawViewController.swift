//
//  TodayLawViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit
import CoreData

class TodayLawViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    let coreDataManager = CoreDataManager.shared
    var categoryList : [String] = ["전체"]
    
    lazy var fetchedResultsController: NSFetchedResultsController<Committee> = {
        let fetchRequest: NSFetchRequest<Committee> = Committee.fetchRequest()

        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 20

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: coreDataManager.container!, sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    public lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommitteeCustomCell.self, forCellWithReuseIdentifier: "CommitteeCellId")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public lazy var todayLawCollectionView: UICollectionView = {
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "오늘의 법안"
        [categoryCollectionView, todayLawCollectionView, categoryCollectionView].forEach { view.addSubview($0) }
        
        todayLawCollectionView.dataSource = self
        todayLawCollectionView.delegate = self

        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        fetchCoreData()
        configureConstraints()
    }
    
    private func fetchCoreData() {
        do {
            try fetchedResultsController.performFetch()
            
            fetchedResultsController.fetchedObjects?.forEach { item in
                categoryList.append(item.name!)
            }
        
            categoryCollectionView.reloadData()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Lifecycle
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: screenHeight / 15),
            
            todayLawCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: screenHeight / 42),
            todayLawCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayLawCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayLawCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Helpers & fuction
    
}

extension TodayLawViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case categoryCollectionView:
                return categoryList.count
            case todayLawCollectionView:
                return 10
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case todayLawCollectionView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayLawCollectionViewCell.reuseIdentifier, for: indexPath) as? TodayLawCollectionViewCell else { return UICollectionViewCell() }
                
                cell.setShadow(offset: CGSize(width: 0.3, height: 0.3), color: .lightGray, radius: 5, opacity: 0.4)
                
                return cell
                
            case categoryCollectionView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitteeCellId", for: indexPath) as? CommitteeCustomCell else { return UICollectionViewCell() }

                cell.backgroundColor = UIColor.customUnselectedGreen
                if indexPath.item == 0 {
                    cell.configure()
                    /// 다른 Cell 을 눌렀을 떄 "전체" Cell 의 seleted 를 없애기 위한 코드
                    collectionView.selectItem(at: indexPath,
                                              animated: false,
                                              scrollPosition: .init())
                }
                cell.categoryLabel.text = categoryList[indexPath.row]

                return cell
                
            default:
                return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            case categoryCollectionView:
                return CGSize(width: screenWidth / 5.82, height: screenHeight / 24.82)
                
            case todayLawCollectionView:
                let collectionViewCellWidth = screenWidth / 1.09
                let collectionViewCellHeight = screenHeight / 7.15
                return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
                
            default:
                return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: categoryCollectioView 인 경우 처리하기
//        switch collectionView {
//            case todayLawCollectionView:
//                let detailViewController = DetailViewController()
//                navigationController?.pushViewController(detailViewController, animated: true)
//            case categoryCollectionView:
//
//            default:
//
//        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
            case categoryCollectionView:
                return UIEdgeInsets(top: 0, left: screenWidth / 24.38, bottom: 0, right: screenWidth / 24.38)
            case todayLawCollectionView:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            default:
                return UIEdgeInsets()
        }

    }
}
