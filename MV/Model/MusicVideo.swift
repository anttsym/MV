//
//  MusicVideo.swift
//  MV
//
//  Created by Анатолий Цымбалов on 11.05.17.
//  Copyright © 2017 Анатолий Цымбалов. All rights reserved.
//



import Foundation

class Videos {
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    private var _arrayOfNames:JSONArray
    
    
    // getters
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return self.vImageUrl // ?
    }
    
    var vVideoUrl: String {
        return _vImageUrl
    }
    
    var arrayOfNames: JSONArray {
        return _arrayOfNames //as JSONArray
    }

    
    
    // Получим ошибку, если не инициализируем
    init(data: JSONDictionary) {                                // Передаем сюда словарь // Производим парсинг
        
//        // Добираемся до имени
//        if let name = data["im:name"] as? JSONDictionary,
//        //if let name = data["feed"] as? JSONDictionary,
//             let vName = name["label"] as? String {
//            _vName = vName                                 // В этом случае инициализируем
//        } else {
//            _vName = ""
//        }
        
        
        
        // Добираемся до имени
        //if let name = data["im:name"] as? JSONDictionary,
        if let name = data["feed"] as? JSONDictionary,
            let vName = name["entry"] as? JSONDictionary, // Если значений больше 1 то вернется массив
            //let vName = name["entry"] as? NSArray,
            let vName1 = vName["im:name"] as? JSONDictionary,
            let vName2 = vName1["label"] as? String {
            _vName = vName2                                 // В этом случае инициализируем
        } else {
            _vName = ""
        }
        
        
        // Массив названий // РАБОТАЕТ
        if let name = data["feed"] as? JSONDictionary {
            let array1 = (name["entry"] as? JSONArray)! // Это массив // но это массив словарей
            // Реализовать цикл for // или guard ?
            //_arrayOfNames = ["" as AnyObject] // Так мы добавляем лишнюю пустую строчку! // Инициализируем пустой строкой
            _arrayOfNames = JSONArray()         // А так только выделяем память?
            // Мне нужно добавлять в arrayOfNames "label" из каждого словаря
            for dictionary in array1 {
                let im_name_dic = dictionary["im:name"] as! JSONDictionary
                let label = im_name_dic["label"]
                _arrayOfNames.append(label as AnyObject) // потому что в Constants определено typealias JSONArray = Array<AnyObject>
            }
        } else {
            _arrayOfNames = ["" as AnyObject]
        }


        // Добираемся до ссылки на картинку
        if let img  = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            self._vImageUrl =
                immage.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        // Добираемся до ссылки на видео
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
    }
}
