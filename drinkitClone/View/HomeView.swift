//
//  HomeView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 10.09.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var productViewModel : ProductViewModelImpl
    
    
    var body: some View {
        
        ScrollView {
            HeaderView(
                destination: AnyView(CartView().navigationBarBackButtonHidden()),
                
                cartProductsQuantity: productViewModel.cart.count)
            
            
            CategoryListViews
            NavigationLink(destination: ProductCatalogView().navigationBarBackButtonHidden()) {
                HStack {
                    Text("Choco **Collection**")
                        .font(.title)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .imageScale(.large)
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
            }
            
            
            ProductListViews
        }
        
    }
    
    var CategoryListViews: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(productViewModel.categories, id: \.id) {category in
                        VStack {
                            Button(action: {
                                productViewModel.activeCategory = category.title
                                print(productViewModel.activeCategory)
                            }, label: {
                                Text(category.title)
                                    .foregroundStyle(
                                        productViewModel.activeCategory == category.title ? .white : .black
                                    )
                            })
                        }
                        .padding(25)
                        .background(
                            productViewModel.activeCategory == category.title ? .black : .gray.opacity(0.2)
                        )
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(.leading, 25)
    }
    var ProductListViews : some View {
        HStack {
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    if (productViewModel.activeCategory.isEmpty || productViewModel.activeCategory == "All") {
                        ForEach (productViewModel.products) {product in
                            HStack {
                                ProductCardView(product: product, action: {
                                    productViewModel.addToCart(product: product)
                                })
                            }
                        }
                    } else {
                        ForEach (productViewModel.products.filter {
                            $0.category == productViewModel.activeCategory
                        }) {product in
                            HStack {
                                ProductCardView(product: product, action: {
                                    productViewModel.addToCart(product: product)
                                })
                            }
                        }
                    }
                    
                }
                
            }
        }.padding(.leading, 25)
    }
    
}

#Preview {
    HomeView()
        .environmentObject(ProductViewModelImpl())
}
