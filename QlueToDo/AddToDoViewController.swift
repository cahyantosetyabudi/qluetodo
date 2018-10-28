//
//  NetworkService.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    var statusToDo = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusPicker.dataSource = self
        statusPicker.delegate = self
    }

    let status = ["Selesai", "Belum"]

    @IBAction func addToDoButton(_ sender: UIButton) {
//        let todo = ToDo(id: 201, userId: 11, title: "budi", completed: true)
        let dicToDo: Dictionary<String, Any> = [
            "id": 201,
            "userId": 11,
            "title": "\(String(describing: toDoField.text))",
            "completed": statusToDo
        ]
        addToDos(dicToDo)

    }
    
    private let session: URLSession = .shared
    func addToDos(_ toDo: [String: Any]) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: toDo, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
}

extension AddToDoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }
}

extension AddToDoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            statusToDo = true
        } else {
            statusToDo = false
        }
    }
}
