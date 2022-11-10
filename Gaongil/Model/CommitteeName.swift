//
//  CommitteeName.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/10.
//

import Foundation

enum CommitteeName: String {
    case 고용
    case 보건
    case 기술
    case 환경
    case 여성
    case 법
    case 금융
    case 예술
    case 식품
    case 교육
    case 국세
    case 국방
    case 외교
    case 해양
    case 전체

    var fullName: String {
        switch self {
        case .고용: return "산업통상자원중소벤쳐기업위원회"
        case .보건: return "보건복지위원회"
        case .기술: return "과학기술정보방송통신위원회"
        case .환경: return "환경노동위원회"
        case .여성: return "여성가족위원회"
        case .법: return "법제사법위원회"
        case .금융, .국세: return "기획재정위원회"
        case .예술: return "문화체육관광위원회"
        case .식품, .해양: return "농림축산식품해양수산위원회"
        case .교육: return "교육위원회"
        case .국방: return "국방위원회"
        case .외교: return "외교통일위원회"
        case .전체: return ""
        }
    }
}
