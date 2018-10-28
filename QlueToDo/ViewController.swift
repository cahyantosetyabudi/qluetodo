//
//  ViewController.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        tableView.delegate = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EditToDoViewController {
            let viewController = segue.destination as! EditToDoViewController
            let selectedRow = tableView.indexPathForSelectedRow?.row
            viewController.todo = toDos[selectedRow!]
        }
    }
    
    func deleteToDo(_ id: Int) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}

extension ViewController: UITableViewDataSource {
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action:UIContextualAction, view:UIView, nil) in
            self.deleteToDo(self.toDos[indexPath.row].id)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
