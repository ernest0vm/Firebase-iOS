//
//  Shortcut.swift
//  KeyboardShortcuts
//
//  Created by Ernesto Valdez on 9/4/19.
//  Copyright © 2019 Ernesto Valdez. All rights reserved.
//

import Foundation

class Shortcut {
    var name: String = ""
    var keys: [String] = []
    var imageUri: String = ""
    var voteUp: Int64 = 0
    var voteDown: Int64 = 0
    
    init() {
    }
    
    func FromDict(dictionary: NSDictionary) -> Shortcut{
        
        let shortcut = Shortcut()
        shortcut.name = dictionary["name"] as! String
        shortcut.keys = dictionary["keys"] as! [String]
        shortcut.imageUri = dictionary["imageUri"] as! String
        shortcut.voteUp = dictionary["voteUp"] as? Int64 ?? 0
        shortcut.voteDown = dictionary["voteDown"] as? Int64 ?? 0
        return shortcut
    }
    
    func ToDictionary() -> NSDictionary {
        
        let dictionary: NSDictionary = [
            "name" : name,
            "keys" : keys,
            "imageUri" : imageUri,
            "voteUp" : voteUp,
            "voteDown" : voteDown
        ]
        
        return dictionary
    }
    
    func ToString() -> String {
        let stringBuilder: String = "name: \(name), Keys: \(keys), imageUri: \(imageUri), voteUP: \(voteUp), voteDown: \(voteDown)]"
        
        return stringBuilder
    }
}
