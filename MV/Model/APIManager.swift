//
//  APIManager.swift
//  MV
//
//  Created by Анатолий Цымбалов on 10.05.17.
//  Copyright © 2017 Анатолий Цымбалов. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String,
                  complition: @escaping (_ result:String) -> Void)  // Что это?
                // complition: @escaping (_ result:String) -> ())  // Void и () равнозначны
    {
        //let session = URLSession.shared                             // Создаем указатель на сессию с помощью обращения к синглтону
        
        let config = URLSessionConfiguration.ephemeral              // Другой вариант
        let session = URLSession(configuration: config)
        
        
        let url = URL(string: urlString)!                           // Создает url-строку из строки которую мы передали в метод loadData
        
        let task = session.dataTask(with: url) {
            (data, response, error) -> Void in                      // data - это ...
                                                                    // response - это http-response
            
            DispatchQueue.main.async {
                if error != nil {
                    complition((error!.localizedDescription))       // localizedDescription - полная причина почему операция не удалась
                } else {
                    complition("NSURLSession successful")
                    //print(data!) выведет количество байт
                    //print(data as Any)
                    //print(data as NSData!)                          // ? Опасно ?
                    print(data as NSData?)                          // Более правильно // Ведь ответа может и не быть
                }
            }
        }
        task.resume()                                               // Если не напишем, то task никогда не выполнится
    }
}
