//
//  ProductModel.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 09.09.2024.
//

import SwiftUI


struct ProductModel : Identifiable{
    var id = UUID()
    var title : String
    var price : Double
    var category : String
    var color : Color
}
