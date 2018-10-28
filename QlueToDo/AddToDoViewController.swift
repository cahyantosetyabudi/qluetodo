//
//  NetworkService.swift
//  QlueToDo
//
//  Created by Cahyanto Setya Budi on 10/28/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusPicker.dataSource = self
        statusPicker.delegate = self
    }

    let status = ["Selesai", "Belum"]
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
