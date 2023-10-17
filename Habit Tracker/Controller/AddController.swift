//
//  AddController.swift
//  Habit Tracker
//
//  Created by Dennis Münchow on 17.10.23.
//

import UIKit
import CoreData


class AddController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var completion : ((String, String, Date) -> Void)?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory: String?
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        noteField.delegate = self
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if let titleText = titleField.text, !titleText.isEmpty,
           let noteText = noteField.text, !noteText.isEmpty {
            
            let targetDate = datePicker.date
            
            let newItem = Item(context: self.context)
            newItem.title = titleText
            newItem.done = false
            newItem.category = self.selectedCategory
            newItem.date = targetDate
            
            print(newItem.title, newItem.done, newItem.category)
            
            
            self.itemArray.append(newItem)
            self.saveItems()
            
            
            dismiss(animated: true, completion: nil)
            
            completion?(titleText, noteText, targetDate)
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveItems () {
        do {
            try context.save()
        } catch {
            print("Error saving contect \(error)")
        }
    }
}
