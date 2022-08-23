//
//  ViewModel.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 17/08/2022.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var drinkArr: [Cocktail.Drink] = [Cocktail.Drink(strDrink: "Czysta", strDrinkThumb: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUFKYcXuM4onp47mQIIb5AgwVG6EXUWuZ6HGw7-7s&s", idDrink: "9999999")]
        @Published var ingredientArr: [Ingredients.Ingredient] = [Ingredients.Ingredient(strIngredient1: "Bakłażan")]
        @Published var chosenIngredient: String = "Vodka"
        
        func getDrinksData() async {
            let url_base = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
            print("trying to access")
            let temp_url = url_base + self.chosenIngredient
            
            print("create url")
            print(temp_url)
            
            guard let url = URL(string: temp_url) else {
                print("Invalid url. URL: \(temp_url)")
//                completed()
                return
            }
            
            print("create session")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                do {
                    let returned = try JSONDecoder().decode(Cocktail.Returned.self, from: data!)
                    self.drinkArr.append(contentsOf: returned.drinks)
//                    self.drinkArr = returned.drinks
                } catch {
                    print("JSON error. \(error.localizedDescription)")
                    print(String(describing: error))
                }
                print("completed")
//                completed()
            }
            print("resumed")
            task.resume()
        }
        
        func getIngredientsData() async {
            let url_base = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
            print("trying to access")
            
            print("create url")
            
            guard let url = URL(string: url_base) else {
                print("Invalid url. URL: \(url_base)")
//                completed()
                return
            }
            
            print("create session")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                do {
                    let returned = try JSONDecoder().decode(Ingredients.Returned.self, from: data!)
                    self.ingredientArr = self.ingredientArr + returned.drinks
                    print(self.ingredientArr.count)
//                    self.drinkArr = returned.drinks
                } catch {
                    print("JSON error. \(error.localizedDescription)")
                    print(String(describing: error))
                }
                print("completed")
//                completed()
            }
            print("resumed")
            task.resume()
        }
    }
}
