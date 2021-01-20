//
//  ItemsStruct.swift
//  final_project
//
//  Created by 林湘羚 on 2021/1/1.
//

import Foundation
struct FoodItems:Codable{
    let items:[FoodItem]
    
    struct FoodItem:Codable{
        let title:String
        let link:String
        let pagemap:FoodPagemap
        
        struct FoodPagemap:Codable{
            let cse_thumbnail:[FoodSrc]
            let metatags:[FoodOg]
            
            struct FoodSrc:Codable{
                let src:String
            }
            struct FoodOg:Codable{
                let og_title:String
                let og_description:String
                
                enum CodingKeys: String, CodingKey {
                      case og_title = "og:title"
                      case og_description = "og:description"
                   }
            }
        }
    }
}

extension FoodItems {
    init() {
        items=[]
    }
}


