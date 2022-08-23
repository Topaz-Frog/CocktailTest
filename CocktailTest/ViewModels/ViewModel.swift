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
        
        func getDrinksData() async {
            let url_base = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
//            print("trying to access")
            let url_ingredient = self.chosenIngredient.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
            let temp_url = url_base + url_ingredient
            
//            print("create url")
//            print(temp_url)
            
            guard let url = URL(string: temp_url) else {
                print("Invalid url. URL: \(temp_url)")
                return
            }
            
//            print("create session")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                do {
                    let returned = try JSONDecoder().decode(Drinks.Returned.self, from: data!)
//                    self.drinkArr.append(contentsOf: returned.drinks)
                    self.drinkArr = returned.drinks
                    print(self.drinkArr.count)
                } catch {
                    print("JSON error. \(error.localizedDescription)")
                    print(String(describing: error))
                }
//                print("completed")
            }
//            print("resumed")
            task.resume()
        }
        
        func getIngredientsData() async {
            let url_base = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
            print("trying to access")
            
//            print("create url")
            
            guard let url = URL(string: url_base) else {
                print("Invalid url. URL: \(url_base)")
                return
            }
            
//            print("create session")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                do {
                    let returned = try JSONDecoder().decode(Ingredients.Returned.self, from: data!)
//                    self.ingredientArr = self.ingredientArr + returned.drinks
//                    print(self.ingredientArr.count)
                    self.ingredientArr = returned.drinks.sorted(by: { $0.strIngredient1 < $1.strIngredient1 })
//                    self.ingredientArr.sorted(by: { $0.strIngredient1 > $1.strIngredient1 })
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
