//
//  ContentView.swift
//  CocktailTest
//
//  Created by Erwin Marysiok on 17/08/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var isDrinkDisplayed:Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color("Rosewood")
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Color("Dark Sienna")
                        .ignoresSafeArea()
                        .frame(height: 70)
                    
                    HStack {
                        Text("Chosen ingredient: \(viewModel.chosenIngredient)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Menu {
                            ForEach(viewModel.ingredientArr) { item in
                                Button("\(item.strIngredient1)") {
                                    Task {
                                        await viewModel.getDrinksData()
                                    }
                                    viewModel.chosenIngredient = item.strIngredient1
                                }
                            }
                        } label: {
                            Label("Change", systemImage: "ellipsis")
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(Color("Burnt Sienna"))
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach($viewModel.drinkArr) { $item in
                            // open drink description
                            Button {
                                Task {
                                    await viewModel.getExtendedDrinkData(drinkID: item.idDrink)
                                }
                                withAnimation {
                                    self.isDrinkDisplayed.toggle()
                                }
                            } label: {
                                DrinkButton(drink: $item)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
//                .refreshable {
//                    await viewModel.getDrinksData()
//                }
                .task {
                    await viewModel.getDrinksData()
                    await viewModel.getIngredientsData()
                }
            }
            
            if isDrinkDisplayed {
                DrinkDescription(drink: $viewModel.openedDrink, isDrinkDisplayed: $isDrinkDisplayed)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
