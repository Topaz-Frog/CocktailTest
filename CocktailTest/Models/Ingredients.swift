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
    
    struct Ingredient: Identifiable, Codable {
        var id: String { strIngredient1 }
        
        var strIngredient1: String
    }
}
