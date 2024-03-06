//
//  Pet.swift
//  NetworkingAPI-Pets
//
//  Created by Razan alshatti on 04/03/2024.
//

import Foundation

struct Pet: Codable{
    var id: Int? = 0
    var name: String
    var adopted: Bool
    var image: String
    var age: Int
    var gender: String

}

