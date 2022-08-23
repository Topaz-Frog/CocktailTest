//
//  Ingredients.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 23/08/2022.
//

import Foundation

class Ingredients {
    struct Returned: Codable {
        var drinks: [Ingredient]
    }
    
    struct Ingredient: Codable {
        var strIngredient1: String
    }
}
