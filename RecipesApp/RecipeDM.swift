//
//  RecipeDM.swift
//  RecipesApp
//
//  Created by Smita Kankayya on 17/02/24.
//

import Foundation

struct RecipeDM: Decodable {
    let recipes: [Recipe]?
}

struct Recipe: Decodable {
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let tags: [String]
    let image: String
    let rating: Double
    let reviewCount: Int
    
}
