//
//  JsonParseDictionary.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/6/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation

// code from https://medium.com/swift-programming/4-json-in-swift-144bf5f88ce4
func JSONParseDictionary(string: String) -> [String: AnyObject]{
    
    
    if let data = string.data(using: String.Encoding.utf8){
        
        do{
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]{
                
                return dictionary
                
            }
        }catch {
            
            print("error")
        }
    }
    return [String: AnyObject]()
}



