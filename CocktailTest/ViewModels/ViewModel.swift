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
        
        func getData(ingredient: String) async {
            let url_base = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
            print("trying to access")
            let temp_url = url_base + ingredient
            
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
                    self.drinkArr = self.drinkArr + returned.drinks
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
