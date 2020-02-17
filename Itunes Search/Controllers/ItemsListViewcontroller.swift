//
//  ItemsListViewcontroller.swift
//  Itunes Search
//
//  Created by Didi on 13.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit

class ItemsListViewcontroller: UIViewController {
    
    var itunesFetcher = ItunesFetcher()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    lazy var searchTextField = SearchTextField()

    lazy var searchButton = SearchButton()
  
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .white
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(collectionView)
  
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
   
    func setupConstraints() {
        searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
           
        searchTextField.topAnchor.constraint(equalTo: searchButton.topAnchor).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -20).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant:  40).isActive = true
       
        collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
        
    @objc func search(){
        itunesFetcher.cleanResults()
        let seconds = 1.5
            self.itunesFetcher.getItems(symbol: self.searchTextField.text ?? "")
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.collectionView.reloadData()
        }
    }
    
}

extension ItemsListViewcontroller:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itunesFetcher.resultItems.count
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.textLabel.text = itunesFetcher.resultItems[indexPath.item].name
        cell.imageView.loadImage(urlString: itunesFetcher.resultItems[indexPath.item].item.image)

        return cell
    }
    
}

extension ItemsListViewcontroller:  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
   }
           
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentItemViewModel = itunesFetcher.resultItems[indexPath.item]
        let detailsViewController =  DetailsViewController()
        detailsViewController.itunesFetcher = itunesFetcher
        detailsViewController.itemViewModel = currentItemViewModel      
        detailsViewController.modalPresentationStyle = .fullScreen
        self.present(detailsViewController, animated: true, completion: nil)
   }
    
}
