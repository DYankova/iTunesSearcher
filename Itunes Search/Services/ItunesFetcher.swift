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
                guard let jsonArray = jsonResponse["results"] as? [[String: Any]] else {
                    return
                }
                
                self.fetchItems(jsonArray)

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    
    private func fetchItems(_ results: [[String: Any]]){
         for el in results {
            let item = ItemViewModel(ItemModel(el))
                if self.resultItems.count <= 100 {
                    self.resultItems.append(item)
            }
        }
     }
    
     func cleanResults(){
        resultItems.removeAll()
    }
    
}
