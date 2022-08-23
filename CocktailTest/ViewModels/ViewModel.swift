//
//  ViewModel.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 17/08/2022.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var drinkArr: [Drinks.Drink] = []
        @Published var ingredientArr: [Ingredients.Ingredient] = []
        @Published var chosenIngredient: String = "Vodka"
        @Published var openedDrink: DrinkExtended.Drink = DrinkExtended.Drink(idDrink: "977", strDrink: "Czysta", strDrinkThumb: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUFKYcXuM4onp47mQIIb5AgwVG6EXUWuZ6HGw7-7s&s", strCategory: "Cocktail", strAlcoholic: "Alcoholic", strGlass: "White wine glass", strInstructions: "intruct")
        
        func getData(getIngredients: Bool, drinkID: String?) async {
//            print("trying to access")
            
            var temp_url = ""
            if getIngredients {
//                url for ingredients
                let url_base = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
                temp_url = url_base
            } else if drinkID != nil {
//                url for extended drink
                let url_base = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
                temp_url = url_base + drinkID!
            } else {
//                url for drinks with chosen ingredients
                let url_base = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
                let url_ingredient = self.chosenIngredient.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
                temp_url = url_base + url_ingredient
            }
            
//            print("create url")
            guard let url = URL(string: temp_url) else {
                print("Invalid url. URL: \(temp_url)")
                return
            }
            
//            print("create session")
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { [self] data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
//                decode JSON files
                do {
                    if getIngredients {
                        let returned = try JSONDecoder().decode(Ingredients.Returned.self, from: data!)
                        self.ingredientArr = returned.drinks.sorted(by: { $0.strIngredient1 < $1.strIngredient1 })
                    } else if drinkID != nil {
                        let returned = try JSONDecoder().decode(DrinkExtended.Returned.self, from: data!)
                        self.openedDrink = returned.drinks[0]
                    } else {
                        let returned = try JSONDecoder().decode(Drinks.Returned.self, from: data!)
                        self.drinkArr = returned.drinks
                    }
                    
                } catch {
                    print("JSON error. \(error.localizedDescription)")
                    print(String(describing: error))
                }
//                print("completed")
            }
//            print("resumed")
            task.resume()
        }
    }
}
