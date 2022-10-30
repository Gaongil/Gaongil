//
//  APIConstanrs.swift
//  Gaongil
//
//  Created by Lena on 2022/10/30.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://open.assembly.go.kr/portal/openapi/nxjuyqnxadtotdrbw?AGE=21&KEY=\(myAPIKey)&Type=json"
    static let committeeURL = baseURL + "&CURR_COMMITTEE="
}
