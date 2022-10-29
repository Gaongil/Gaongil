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
    
    func fetchLawData(_ handler: @escaping (([[Row]]) -> Void)) {
        
        let customParameters: Parameters = [
            "age": "21"
        ]
        
        guard let url = URL(string: "https://open.assembly.go.kr/portal/openapi/nxjuyqnxadtotdrbw?AGE=21&KEY=\(myAPIKey)&Type=json") else { fatalError("Invalid URL")
        }
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept":"application/json"
        ]
        
        AF.request(url, method: .post, parameters: customParameters, encoding: JSONEncoding.default, headers: header)
            .response { response in
                switch response.result {
                    case .success(let data):
                        do {
                            guard let data = data else { return }
                            let decoder = JSONDecoder()
                            guard let firstRow = try? decoder.decode(LawResponse.self, from: data) else {
                                return
                            }
                            guard let lists = firstRow.list else { return }
                            
                            let rowBoxes = lists.compactMap { $0.row }
//                            print(rowBoxes)
//                            print(rowBoxes[0][0].billName)
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
    }
}


