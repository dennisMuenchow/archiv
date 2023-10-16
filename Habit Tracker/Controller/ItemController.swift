//
//  ItemController.swift
//  Habit Tracker
//
//  Created by Dennis Münchow on 14.10.23.
//

import UIKit
import CoreData

class ItemController: UITableViewController {
          
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var healthArray = [HealthItem]()
    var relationshipsArray = [RelationshipsItem]()
    var skillsArray = [SkillsItem]()
    var careerArray = [CareerItem]()
    
    var navbarTitle: String?
    var selectedArray: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navbarTitle
        
        if navbarTitle == "Health" {
            selectedArray = healthArray
        } else if navbarTitle == "Relationships" {
            selectedArray = relationshipsArray
        } else if navbarTitle == "Skills" {
            selectedArray = skillsArray
        } else if navbarTitle == "Career" {
            selectedArray = careerArray
        }
        
        
        loadItems()
        print(selectedArray)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthArray.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthItems", for: indexPath)
        let item = healthArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // TERNARY OPERATOR:
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedArray[indexPath.row].done = !selectedArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Health Item", message: "", preferredStyle: .alert)

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
            textField = alertTextField
        }

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newHealthItem = HealthItem(context: self.context)
            newHealthItem.title = textField.text!
            newHealthItem.done = false
            self.selectedArray.append(newHealthItem)
            self.saveItems()
        }

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Mamipulation Methods
    
    func saveItems () {
        do {
            try context.save()
        } catch {
            print("Error saving contect \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<HealthItem> = HealthItem.fetchRequest(), predicate: NSPredicate? = nil) {
        do {
            selectedArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}
