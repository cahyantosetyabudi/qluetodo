//
//  NetworkService.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import Foundation

class NetworkService {
    func parseJSONFromData(_ jsonData: Data?) -> [String: AnyObject]? {
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
                return jsonDictionary
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }

}

extension NetworkService {
}
