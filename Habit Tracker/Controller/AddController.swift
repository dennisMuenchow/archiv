//
//  AddController.swift
//  Habit Tracker
//
//  Created by Dennis Münchow on 17.10.23.
//

import UIKit

class AddController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var completion : ((String, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        noteField.delegate = self
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if let titleText = titleField.text, !titleText.isEmpty,
           let noteText = noteField.text, !noteText.isEmpty {
            
            let targetDate = datePicker.date
            print(targetDate)
            //let targetTime = datePicker.time
            
            completion?(titleText, noteText, targetDate)
            
        }
    }
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    

    
}
