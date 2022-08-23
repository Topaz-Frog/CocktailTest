//
//  ContentView.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 17/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State var drinks = Cocktail()
    @ObservedObject var viewModel = ViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color("Upsdell Red")
                .ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach($viewModel.drinkArr) { $item in
                        DrinkButton(drink: $item)
                    }
                }
                .navigationBarTitle(viewModel.chosenIngredient, displayMode: .inline)
                .padding(.horizontal)
            }
            .task {
                await viewModel.getDrinksData()
                await viewModel.getIngredientsData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
