//
//  ItemModel.swift
//  Itunes Search
//
//  Created by Didi on 13.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit

struct ItemModel {
    
    let name : String
    let image : String
    let url : String
    let kind: String
    let artist: String
         
    init(_ dictionary:  [String: Any])  {
        self.name = dictionary["collectionName"] as? String ?? ""
        self.image = dictionary["artworkUrl100"] as? String ?? ""
        self.url = dictionary["previewUrl"] as? String ?? ""
        self.kind = dictionary["kind"] as? String ?? ""
        self.artist = dictionary["artistName"] as? String ?? ""
    }
    
}
