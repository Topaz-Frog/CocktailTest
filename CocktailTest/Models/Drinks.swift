//
//  Cocktail.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 17/08/2022.
//

import Foundation

class Drinks {
    struct Returned: Codable {
        var drinks: [Drink]
    }
    
    struct Drink: Identifiable, Codable {
        var id: Int { Int(idDrink)! }
        
        var strDrink: String
        var strDrinkThumb: String
        var idDrink: String
    }
}
