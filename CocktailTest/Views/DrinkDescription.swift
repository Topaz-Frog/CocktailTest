//
//  DrinkDescription.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 23/08/2022.
//

import SwiftUI

struct DrinkDescription: View {
    @Binding var drink: DrinkExtended.Drink
    @Binding var isDrinkDisplayed: Bool
    
    var body: some View {
        
        VStack {
            ScrollView {
                ZStack {
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
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    self.isDrinkDisplayed.toggle()
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color("Dark Sienna"))
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                }
                                .frame(width: 32, height: 32, alignment: .topTrailing)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 60)
                            }
                        }
                        Spacer()
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                
                Text(drink.strDrink)
                    .font(.title)
                
                Text("\(drink.strCategory), \(drink.strAlcoholic) drink")
                    .font(.subheadline)
                
                HStack {
                    VStack {
                        Text("Required glass:\n\(drink.strGlass)")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        Text("Required glass: \(drink.strGlass)")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .ignoresSafeArea()
                .padding(.vertical)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .foregroundColor(Color.white)
        .background(Color("Rosewood"))
        
    }
}

struct DrinkDescription_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDescription(drink: .constant(DrinkExtended.Drink(idDrink: "977", strDrink: "Czysta", strDrinkThumb: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUFKYcXuM4onp47mQIIb5AgwVG6EXUWuZ6HGw7-7s&s", strCategory: "Cocktail", strAlcoholic: "Alcoholic", strGlass: "White wine glass", strInstructions: "intruct")), isDrinkDisplayed: .constant(false))
    }
}
