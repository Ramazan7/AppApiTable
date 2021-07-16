//
//  structJson.swift
//  AppApiTable
//
//  Created by Admin on 16.07.2021.
//

import Foundation

struct structJson: Decodable {
    let id:Int
    let name:String
    let tagline:String
    let first_brewed:String
    let description:String
    let image_url:String
}
