//
//  ToDo.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import Foundation

class ToDo {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
    init(userId: Int, id: Int, title: String, completed: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    static func requestAPI() -> [ToDo] {
        var toDo = [ToDo]()
        var networkService = NetworkService()
        
        let jsonFile = Bundle.main.path(forResource: "ToDo", ofType: "json")
        let jsonFileURL = URL(fileURLWithPath: jsonFile!)
        let jsonData = try? Data(contentsOf: jsonFileURL)
        
        if let jsonDictionary = networkService.parseJSONFromData(jsonData) {
            print(jsonDictionary)
//            let toDoDictionaries = jsonDictionary["episodes"] as! [[String : Any]]
//            for toDoDictionary in toDoDictionaries {
//                let newEpisode = Episode(epsDictionary: epsDictionary)
//                episodes.append(newEpisode)
//            }
        }
        
        
        return toDo
    }
}
