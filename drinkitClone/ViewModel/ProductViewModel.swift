//
//  ProductViewModel.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 11.09.2024.
//

import SwiftUI

protocol ProductViewModel {
    func addToCart(product: ProductModel)
    func buyProductsFromCart()
}

final class ProductViewModelImpl : ObservableObject, ProductViewModel {
    @Published var cart : [ProductModel] = []
    @Published var products : [ProductModel] = [
        ProductModel(title: "Coca Cola", price: 1.5, category: "Drinks", color: .red),
        ProductModel(title: "Oreo Cookies", price: 2.0, category: "Snacks", color: .black),
        ProductModel(title: "Cheddar Cheese", price: 4.0, category: "Dairy", color: .orange),
        ProductModel(title: "Apple Juice", price: 3.5, category: "Drinks", color: .green),
        ProductModel(title: "Blueberry Muffin", price: 3.0, category: "Bakery", color: .blue),
        ProductModel(title: "French Baguette", price: 2.5, category: "Bakery", color: .brown),
        ProductModel(title: "Peanut Butter", price: 5.0, category: "Spreads", color: .yellow),
        ProductModel(title: "Tomato Soup", price: 3.2, category: "Canned Goods", color: .red),
        ProductModel(title: "Milk Chocolate", price: 1.8, category: "Sweets", color: .brown),
        ProductModel(title: "Green Tea", price: 2.3, category: "Drinks", color: .green)
    ]
    @Published var categories : [CategoryModel] = [
        CategoryModel(title: "All"),
        CategoryModel(title: "Beverages"),
        CategoryModel(title: "Snacks"),
        CategoryModel(title: "Dairy"),
        CategoryModel(title: "Bakery"),
        CategoryModel(title: "Frozen Foods"),
        CategoryModel(title: "Canned Goods"),
        CategoryModel(title: "Spices"),
        CategoryModel(title: "Sweets"),
        CategoryModel(title: "Fruits"),
        CategoryModel(title: "Vegetables")
    ]
    
    @Published var activeCategory = "All"
    
    func addToCart(product: ProductModel) {
        cart.append(product)
    }
    
    func buyProductsFromCart() {
        cart.removeAll()
    }
}
