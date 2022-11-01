//
//  ResponseManager.swift
//  Gaongil
//
//  Created by Lena on 2022/10/23.
//

import Foundation

import Alamofire
import SwiftyJSON

class ResponseManager {
    var rows: [[Row]] = []
    var lawResponse = [LawResponse]()
    
    static let shared = ResponseManager()
    
    private init() { }
    
    func fetchLawData(_ completionHandler: @escaping (([[Row]]) -> Void)) {
        
        let url = APIConstants.baseURL
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept":"application/json"
        ]
        
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .response { response in
                switch response.result {
                    case .success(let data):
                        do {
                            guard let data = data else { return }
                            let decoder = JSONDecoder()
                            guard let firstRow = try? decoder.decode(LawResponse.self, from: data) else {
                                return
                            }
                            
                            /// 전체 JSON 데이터
                            guard let lists = firstRow.list else { return }
                            print("나는 lists: \(lists)")
                            
                            /// row 데이터들만 모아놓은 프로퍼티
                            let rowBoxes = lists.compactMap { $0.row }
                            print("rowBoxes[0]: \(rowBoxes[0])")
                            print("나는 billName: \(rowBoxes[0][0].billName)")
                            print("나는 billName: \(rowBoxes[0][1].billName)")
                            print("나는 billName: \(rowBoxes[0][1].currCommittee)")
                            print("row들 개수 :\(rowBoxes[0].count)")
                            
                            rowBoxes.forEach { rows in
                                self.rows.append(rows)
                            }
                            completionHandler(rowBoxes)
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
    }

}
