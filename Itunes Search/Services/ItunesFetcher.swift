//
//  ItunesFetcher.swift
//  Itunes Search
//
//  Created by Didi on 13.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit

class ItunesFetcher: UIViewController {

    var resultItems = [ItemViewModel]()
    
    func getItems(symbol: String) {
      
        guard let url = URL(string: "https://itunes.apple.com/search?term="+symbol) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as! [String: Any]
                guard let resultsJsonArray = jsonResponse["results"] as? [[String: Any]] else {
                    return
                }
                self.fetchItems(resultsJsonArray)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    private func fetchItems(_ results: [[String: Any]]){
         for item in results {
            let itemViewModel = ItemViewModel(ItemModel(item))
            itemViewModel.imageView.loadImage(urlString: ItemModel(item).image)
            if self.resultItems.count <= 100 {
                self.resultItems.append(itemViewModel)
            }
        }
     }
    
     func cleanResults(){
        resultItems.removeAll()
    }
    
}
