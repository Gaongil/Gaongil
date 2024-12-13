//
//  String.swift
//  Gaongil
//
//  Created by Lena on 12/13/24.
//


import Foundation

extension String {
    
    func stringToDate() -> (Date, Date) {
        
        let dates = self.split(separator: " ~ ")
        let start = String(dates[0])
        let last = String(dates[1])
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMdd"
        myFormatter.timeZone = NSTimeZone(name: "UTC") as? TimeZone
        
        if let startDate = myFormatter.date(from: start),
           let endDate = myFormatter.date(from: last) {
            return (startDate, endDate)
        }
        return (Date(), Date())
    }
}

extension String {
    func formattedDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd"
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        }
        return nil
    }
}


extension Date {
    func dateToString() -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = myFormatter.string(from: self)
        
        return dateString
    }
}

extension String {
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
    
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData, options: options, documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}

extension NSAttributedString {
    var htmlEscaped: NSAttributedString {
        let htmlString = self.string // NSAttributedString의 string 부분
        guard let encodedData = htmlString.data(using: .utf8) else {
            return self // 데이터 변환 실패 시 원본 반환
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributed = try NSAttributedString(data: encodedData, options: options, documentAttributes: nil)
            return attributed // HTML 이스케이프 적용된 NSAttributedString 반환
        } catch {
            print("HTML parsing error: \(error.localizedDescription)")
            return self // 오류 발생 시 원본 반환
        }
    }
}


