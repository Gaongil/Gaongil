//
//  SettingsViewModel.swift
//  Gaongil
//
//  Created by Seik Oh on 01/11/2022.
//

import Foundation

struct Sections {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let handler: (() -> Void)
}
