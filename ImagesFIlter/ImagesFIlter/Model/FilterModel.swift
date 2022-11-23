//
//  FilterModel.swift
//  ImagesFIlter
//
//  Created by Ahmed Abuelmagd on 23/11/2022.
//

import Foundation

struct FilterModel: Codable {
    let id: Int
    let title: String
    let name: String
    var isSelected: Bool = false
}
