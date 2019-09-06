//
//  Shortcut.swift
//  KeyboardShortcuts
//
//  Created by Ernesto Valdez on 9/4/19.
//  Copyright © 2019 Ernesto Valdez. All rights reserved.
//

import Foundation

class Shortcut {
    var ShortcutName: NSString = ""
    var Keys: [NSString] = []
    var imageUri: NSString = ""
    var voteUP: NSNumber = 0
    var voteDown: NSNumber = 0
    
    init() {
    }
    
    func ToDictionary() -> NSDictionary {
        
        let dictionary: NSDictionary = [
            "name" : ShortcutName,
            "keys" : Keys,
            "imageUri" : imageUri,
            "voteUP" : voteUP,
            "voteDown" : voteDown
        ]
        
        return dictionary
    }
}
