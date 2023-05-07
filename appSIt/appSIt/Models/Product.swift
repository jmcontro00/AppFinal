//
//  Product.swift
//  appSIt
//
//  Created by Amieva on 06/05/23.
//

import Foundation

struct Product: Identifiable {
    var id: String = UUID().uuidString
    var pieza: String
    var marca: String
    var modelo: String
    var año: String
    var codigo: String
    var ubicacion: String
}
