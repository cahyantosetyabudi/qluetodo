//
//  ViewController.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var toDos: [ToDo] = [] {
        didSet
        {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadToDos()
    }
    
    private let session: URLSession = .shared
    func loadToDos() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.toDos = try parse(data)
            }
            catch {
                print("Error: \(error)")
            }
        }
        task.resume()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.toDoLabel.text = toDos[indexPath.row].title
        if toDos[indexPath.row].completed {
            cell.statusToDos.text = "Selesai"
        } else {
            cell.statusToDos.text = "Belum"
        }
                
        return cell
    }
    

}

