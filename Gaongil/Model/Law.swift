
import Foundation
import Alamofire

// MARK: - LawResponse
struct LawResponse: Codable {
    var list: [List]?

    enum CodingKeys: String, CodingKey {
        case list = "nxjuyqnxadtotdrbw"
    }
}

// MARK: - List
struct List: Codable {
    var head: [Head]?
    var row: [Row]?

    enum CodingKeys: String, CodingKey {
        case head = "head"
        case row = "row"
    }
}

// MARK: - Head
struct Head: Codable {
    var listTotalCount: Int?
    var result: Result?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable {
    var code: String?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct Row: Codable {
    var billId: String?
    var billNo: String?
    var age: String?
    var billName: String?
    var proposer: String?
    var proposerKind: String?
    var proposeDt: String?
    var procResultCd: String?
    var currCommitteeId: String?
    var currCommittee: String?
    var committeeDt: String?
    var procDt: String?
    var linkUrl: String?

    enum CodingKeys: String, CodingKey {
        case billId = "BILL_ID"
        case billNo = "BILL_NO"
        case age = "AGE"
        case billName = "BILL_NAME"
        case proposer = "PROPOSER"
        case proposerKind = "PROPOSER_KIND"
        case proposeDt = "PROPOSE_DT"
        case procResultCd = "PROC_RESULT_CD"
        case currCommitteeId = "CURR_COMMITTEE_ID"
        case currCommittee = "CURR_COMMITTEE"
        case committeeDt = "COMMITTEE_DT"
        case procDt = "PROC_DT"
        case linkUrl = "LINK_URL"
    }
}
