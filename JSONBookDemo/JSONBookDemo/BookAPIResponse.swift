//
//  Book.swift
//  JSONBookDemo
//
//  Created by Mac on 11/05/23.
//

import Foundation
struct BookAPIResponse : Codable{
    var error :String
    var total :String
    var books : [Book]
}


struct Book  : Codable {
    var title : String
    var subtitle : String
    var isbn13  : String
    var price : String
}
