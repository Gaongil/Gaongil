//
//  Category.swift
//  Gaongil
//
//  Created by Lena on 2022/10/16.
//

import Foundation

struct Category {
    var name: String
}

extension Category {
    static let categoryNames = [
        Category(name: "고용"),
        Category(name: "보건"),
        Category(name: "기술"),
        Category(name: "환경"),
        Category(name: "여성"),
        Category(name: "법"),
        Category(name: "금융"),
        Category(name: "예술"),
        Category(name: "식품"),
        Category(name: "교육"),
        Category(name: "국세"),
        Category(name: "국방"),
        Category(name: "외교"),
        Category(name: "해양")
    ]
}
