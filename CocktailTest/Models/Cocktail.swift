//
//  Cocktail.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 17/08/2022.
//

import Foundation

class Cocktail {
    var name: String
    var image_url: String
    var id: Int
    
    init(name:String, image_url:String, id:Int) {
        self.name = name
        self.image_url = image_url
        self.id = id
    }
}
