//
//  EditToDoViewController.swift
//  QlueToDo
//
//  Created by Adam Mukharil Bachtiar on 28/10/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class EditToDoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var toDoStatusLabel: UILabel!
    @IBOutlet weak var toDoStatusPicker: UIPickerView!
    
    let status = ["Selesai", "Belum"]
    var todo: ToDo?
    var statusToDo: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoField.text = todo?.title

        toDoStatusPicker.delegate = self
        toDoStatusPicker.dataSource = self
        
        if (todo?.completed)! {
            self.toDoStatusPicker.selectRow(0, inComponent: 0, animated: true)
        } else {
            self.toDoStatusPicker.selectRow(1, inComponent: 0, animated: true)
        }

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return status[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            statusToDo = true
        } else {
            statusToDo = false
        }
    }
    
    @IBAction func simpanButton(_ sender: UIButton) {
        let dicToDo: Dictionary<String, Any> = [
            "id": 201,
            "userId": 11,
            "title": "\(String(describing: toDoField.text))",
            "completed": statusToDo
        ]
        editToDo(dicToDo)
    }
    
    private let session: URLSession = .shared
    func editToDo(_ toDo: [String: Any]) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(todo?.id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
