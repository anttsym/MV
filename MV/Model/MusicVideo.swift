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
    
    
    // Получим ошибку, если не инициализируем
    init(data: JSONDictionary) {                                // Передаем сюда словарь // Производим парсинг
        
        // Добираемся до имени
        if let name = data["im:name"] as? JSONDictionary,
             let vName = name["label"] as? String {
            _vName = vName                                 // В этом случае инициализируем
        } else {
            _vName = ""
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
