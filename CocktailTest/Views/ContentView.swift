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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach($viewModel.drinkArr) { $item in
                    ExtractedView(drink: $item)
                }
            }
        }
        .task {
            await viewModel.getData(ingredient: "Vodka")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExtractedView: View {
    @Binding var drink: Cocktail.Drink
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: drink.strDrinkThumb)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(height: 200)
            
            Text(drink.strDrink)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
        }
    }
}
