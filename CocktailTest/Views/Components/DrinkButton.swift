//
//  DrinkButton.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 22/08/2022.
//

import SwiftUI

struct DrinkButton: View {
    @Binding var drink: Drinks.Drink
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: drink.strDrinkThumb)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            
            Text(drink.strDrink)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
                .frame(minHeight: 60)
        }
        .foregroundColor(Color.white)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("Dark Sienna"))
        .cornerRadius(15)
    }
}

struct DrinkButton_Previews: PreviewProvider {
    static var previews: some View {
        DrinkButton(drink: .constant(Drinks.Drink(strDrink: "Czysta", strDrinkThumb: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUFKYcXuM4onp47mQIIb5AgwVG6EXUWuZ6HGw7-7s&s", idDrink: "9999999")))
    }
}
