//
//  FavoriteViewController.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/10/22.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    let coreDataManager = CoreDataManager.shared
    lazy var result = [NSManagedObject]()
    weak var delegate : SendUpdateProtocol?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Favorite> = {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()

        let sort = NSSortDescriptor(key: "lawTitle", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 20

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: coreDataManager.container!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private var favoriteLawCollectionView: UICollectionView = {
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
        self.navigationItem.title = "관심 법안"
        
        [favoriteLawCollectionView].forEach { view.addSubview($0) }
        
        favoriteLawCollectionView.dataSource = self
        favoriteLawCollectionView.delegate = self
        
        configureConstraints()
        
        do {
            try fetchedResultsController.performFetch()
            
            fetchedResultsController.fetchedObjects?.forEach { item in
                result.append(item)
            }
            favoriteLawCollectionView.reloadData()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteLawCollectionView.reloadData()
    }
    
    // MARK: - Lifecycle
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            favoriteLawCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteLawCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteLawCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteLawCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Helpers & fuction
    
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayLawCollectionViewCell.reuseIdentifier, for: indexPath) as? TodayLawCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setShadow(offset: CGSize(width: 0.3, height: 0.3), color: .lightGray, radius: 5, opacity: 0.4)
        
        let record = self.result[indexPath.row]
        
        cell.titleLabel.text = record.value(forKey: "lawTitle") as? String
        cell.committeeLabel.text = record.value(forKey: "institute") as? String
        
        let progressResult = record.value(forKey: "progress") as? String
        
        if progressResult == "원안가결" {
            cell.circleView.backgroundColor = .customSelectedGreen
        } else if progressResult == "수정가결" {
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
        let detailViewController = FavoriteDetailViewController()

        detailViewController.result = result
        detailViewController.selectedIndex = indexPath.row
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

