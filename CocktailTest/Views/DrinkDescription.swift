//
//  DrinkDescription.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 23/08/2022.
//

import SwiftUI

struct DrinkDescription: View {
    @State var drink: Drinks.Drink = Drinks.Drink(strDrink: "Czysta", strDrinkThumb: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUFKYcXuM4onp47mQIIb5AgwVG6EXUWuZ6HGw7-7s&s", idDrink: "9999999")
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DrinkDescription_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDescription()
    }
}
