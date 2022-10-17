//
//  Category.swift
//  Gaongil
//
//  Created by Lena on 2022/10/16.
//

import Foundation

struct Category {
    var name: String
    var isCategorySelected: Bool
}

extension Category {
    static let categoryNames = [
        Category(name: "고용", isCategorySelected: false),
        Category(name: "보건", isCategorySelected: false),
        Category(name: "기술", isCategorySelected: false),
        Category(name: "환경", isCategorySelected: false),
        Category(name: "여성", isCategorySelected: false),
        Category(name: "법", isCategorySelected: false),
        Category(name: "금융", isCategorySelected: false),
        Category(name: "예술", isCategorySelected: false),
        Category(name: "식품", isCategorySelected: false),
        Category(name: "교육", isCategorySelected: false),
        Category(name: "국세", isCategorySelected: false),
        Category(name: "국방", isCategorySelected: false),
        Category(name: "외교", isCategorySelected: false),
        Category(name: "해양", isCategorySelected: false)
    ]
}
