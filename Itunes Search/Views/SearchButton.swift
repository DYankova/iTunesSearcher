//
//  SearchButton.swift
//  Itunes Search
//
//  Created by Didi on 13.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit

class SearchButton: UIButton {

    override init(frame: CGRect) {
       super.init(frame: frame)
       setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .darkGray
        setTitle("Search", for: .normal)
        layer.cornerRadius = 4
        titleLabel?.font = .systemFont(ofSize: 14)
        translatesAutoresizingMaskIntoConstraints = false
   }

}
