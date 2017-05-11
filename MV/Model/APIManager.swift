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
        
        // ПЕРЕДАЛИ СТРОКУ
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
                    
        // ПОЛУЧИЛИ БИНАРНЫЕ ДАННЫЕ
                    print(data as NSData?)                          // Более правильно // Ведь ответа может и не быть
                    
                    
                    do {
                        
                        if let json =
                            try JSONSerialization.jsonObject(with: data!,                                                   // Возьми data и сконвертируй в json object для нас // ! - значит Forse unwrap
                                                             options: JSONSerialization.ReadingOptions.allowFragments)      // iTunes json - это dictionary
                                as AnyObject?
                        {
        // ... ПОЛУЧИЛИ JSON
                            print(json)
        // ... НАПЕЧАТАЛИ JSON
                            
                            
        // ПОПРОБУЕМ ВЫВЕСТИ НАЗВАНИЯ ...
                            let musicVideo = Videos(data: json as! JSONDictionary)
                            print(musicVideo.vName)
                            
        // ... ЭТО РАБОТАЕТ ТОЛЬКО // ЕСЛИ У НАС ОДНО ЗНАЧЕНИЕ
                            
        // ПОПРОБУЕМ МАССИВ ...
                            
                            //let musicVideo = Videos(data: json as! JSONDictionary)
                            print(musicVideo.arrayOfNames)
                            
                            
                            
                            //let priority = DispatchQueue.GlobalQueuePriority.high                                 // Не работает  // Есть .high .default .low .background - все deprecated // use qos
                            let priority = DispatchQueue.global(qos: .background)                                   // Работает     // Как получить аналог priority .high
                            // let priority = DispatchQoS(qosClass: .background, relativePriority: 0)               // Не работает
                            // DispatchQueue.global(priority, 0).async {                                            // Не работает
                            priority.async {
                                DispatchQueue.main.async {
                                    complition("JSONSerialization successful")
                                }
                            }
                        }
                    } catch {
        // ЕСЛИ  ПОЛУЧИЛИ ОШИБКУ, ТО ВЫВОДИМ ЕЁ
                        DispatchQueue.main.async {
                            complition("error in JSONSerialization")
                        }
                    }
                }
            }
        }
        task.resume()                                               // Если не напишем, то task никогда не выполнится
    }
}
