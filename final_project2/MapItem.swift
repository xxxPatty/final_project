//
//  ItemsStruct.swift
//  final_project
//
//  Created by 林湘羚 on 2021/1/1.
//

import Foundation
struct MapItems:Codable{
    let results:[MapItem]
    
    struct MapItem:Codable{
        let geometry:Location
        
        struct Location:Codable{
            let location: Position

            struct Position:Codable{
                let lat:Double
                let lng:Double
            }
        }
    }
}

extension MapItems {
    init() {
        results=[]
    }
}


