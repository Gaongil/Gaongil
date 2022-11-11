//
//  CoreDataManager.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/02.
//

import UIKit
import CoreData

class CoreDataManager {
    
    /// Core Data 를 관리 하기 위한 객체를 싱글톤으로 생성
    static let shared: CoreDataManager = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var container = appDelegate?.persistentContainer.viewContext
    
    lazy var fetchedResultsController: NSFetchedResultsController<Committee> = {
        let fetchRequest: NSFetchRequest<Committee> = Committee.fetchRequest()

        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 20

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: container!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    lazy var fetchedFavoriteController: NSFetchedResultsController<Favorite> = {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()

        let sort = NSSortDescriptor(key: "lawTitle", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 20

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: container!, sectionNameKeyPath: nil, cacheName: nil)
    
        return fetchedResultsController
    }()
    
//    lazy var fetchedFavoriteController: NSFetchedResultsController<Favorite> = {
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//
//        let sort = NSSortDescriptor(key: "name", ascending: true)
////        fetchRequest.sortDescriptors = [sort]
//        fetchRequest.fetchBatchSize = 50
//
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
//                                                                  managedObjectContext: container!, sectionNameKeyPath: nil, cacheName: nil)
//        return fetchedResultsController
//    }()
    
    // MARK: - Save Core Data
    
    func saveCommitteeCoreData(name: String, isCategorySelected: Bool, completion: @escaping (Bool) -> Void) {
        guard let container = self.container,
              let entity = NSEntityDescription.entity(forEntityName: "Committee", in: container) else {return}
        
        guard let committeeData = NSManagedObject(entity: entity, insertInto: container) as? Committee else {return}
        
        committeeData.name = name
        committeeData.isSelected = isCategorySelected
        
        do {
            try container.save()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func saveFavoriteCoreData(lawTitle: String, institute: String, progress: String, proposer: String, suggestionDate: String, contentText: String, completion: @escaping (Bool) -> Void) {
        guard let container = self.container,
              let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: container) else {return}
        
        guard let favoriteData = NSManagedObject(entity: entity, insertInto: container) as? Favorite else {return}
        
        favoriteData.lawTitle = lawTitle
        favoriteData.institute = institute
        favoriteData.progress = progress
        favoriteData.proposer = progress
        favoriteData.suggestionDate = suggestionDate
        favoriteData.contentText = contentText
        
        do {
            try container.save()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    // MARK: - Load Core Data
    
    func loadCoreData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        guard let container = self.container else { return [] }
        do {
            let result = try container.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Delete Core Data
    
    func deleteCoreData<T: NSManagedObject>(at index: Int, request: NSFetchRequest<T>) -> Bool {
        request.predicate = NSPredicate(format: "index = %@", NSNumber(value: index))
        
        do {
            if let recentTerms = try container?.fetch(request) {
                if recentTerms.count == 0 { return false }
                container?.delete(recentTerms[0])
                try container?.save()
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return false
    }
}
