//
//  DetailsViewController.swift
//  Itunes Search
//
//  Created by Didi on 13.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var itemViewModel: ItemViewModel!
    var itunesFetcher = ItunesFetcher()
    
    lazy var imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
            
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Robonto", size: 20)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textLabelMoreInfo: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Robonto", size: 17)
        textView.dataDetectorTypes = .link
        textView.isSelectable = true
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
   }()
        
    lazy var deleteButton: UIButton = {
        let btn = UIButton()
        btn.tintColor = .darkGray
        btn.setTitleColor(.blue, for: .normal)
        if let image = UIImage(named: "delete") {
            btn.setImage(image, for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        return btn
    }()

    lazy var closeButton: UIButton = {
         let btn = UIButton()
         if let image = UIImage(named: "close") {
             btn.setImage(image, for: .normal)
         }
         btn.translatesAutoresizingMaskIntoConstraints = false
         btn.addTarget(self, action: #selector(close), for: .touchUpInside)
         return btn
    }()

    func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(deleteButton)
        view.addSubview(imageView)
        view.addSubview(textLabel)
        view.addSubview(textLabelMoreInfo)

        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: closeButton.topAnchor).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
                
        imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100 ).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100 ).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        textLabelMoreInfo.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
        textLabelMoreInfo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        textLabelMoreInfo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        textLabelMoreInfo.widthAnchor.constraint(equalTo: view!.widthAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        imageView.loadImage(urlString: itemViewModel.item.image)
        textLabel.text = itemViewModel.text
        textLabelMoreInfo.attributedText = itemViewModel.previewLink
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
        
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
   }

    @objc func deleteItem(){
        itunesFetcher.resultItems.removeAll{$0 === itemViewModel }
        self.dismiss(animated: true, completion: nil)
    }
      
}
