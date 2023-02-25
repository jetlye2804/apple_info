//
//  Product.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 19/02/2023.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var path: String
}
