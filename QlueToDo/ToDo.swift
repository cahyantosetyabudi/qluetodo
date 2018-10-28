//
//  ToDo.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import Foundation

struct ToDo: Codable
{
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}


extension ToDo: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.id = try decoder.value(forKey: "id")
        self.userId = try decoder.value(forKey: "userId")
        self.title = try decoder.value(forKey: "title")
        self.completed = try decoder.value(forKey: "completed")
    }
}

//extension ToDo: Coda {
//    func toJSON() throws -> Any {
//        return try JSONEncoder.init()
//    }
//}
