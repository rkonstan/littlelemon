//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Rick Konstan on 20/3/2024.
//

import Foundation

struct MenuItem: Codable, Hashable {
    
    let title: String
    let image: String
    let price: String
    let category: String
 
    enum CodingKeys: String, CodingKey {
            case title = "title"
            case image = "image"
            case price = "price"
            case category = "category"

        }
}
