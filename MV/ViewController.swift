//
//  ViewController.swift
//  MV
//
//  Created by Анатолий Цымбалов on 10.05.17.
//  Copyright © 2017 Анатолий Цымбалов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        
        // 1 вариант
        api.loadData(urlString: "http://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", complition: didLoadData)
        
        // 2 вариант - передать функцию - называется trailing clousure
        api.loadData(urlString: "http://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
            (result:String) in
            print(result)
        }
    }

    // Это callback или complition handler
    func didLoadData(result:String) {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        print(result)
    }

}

