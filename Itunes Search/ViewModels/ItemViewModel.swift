//
//  ItemViewModel.swift
//  Itunes Search
//
//  Created by Didi on 13.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit
import Foundation

class ItemViewModel  {
       
    let item: ItemModel
    
    init(_ item: ItemModel) {
        self.item = item
    }
    
    var name: String {
        item.name
    }
    var text : String {
        return "Name: " + name + " \nType: " + item.kind + " \nArtist: " + item.artist
    }
    
    var imageView = CustomImageView()

    var url: String {
       return item.url
    }
    
    var previewLink: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: url, attributes:[NSAttributedString.Key.link: URL(string: url)])
        return attributedString
    }

}
