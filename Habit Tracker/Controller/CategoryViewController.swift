//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Dennis Münchow on 14.10.23.
//

import UIKit
import CoreData


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Item]()
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
    }
    
    @IBAction func healthPressed(_ sender: UIButton) {
        selectedCategory = "Health"
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    @IBAction func relationshipsPressed(_ sender: UIButton) {
        selectedCategory = "Relationships"
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    @IBAction func skillsPressed(_ sender: UIButton) {
        selectedCategory = "Skills"
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    @IBAction func careerPressed(_ sender: UIButton) {
        selectedCategory = "Career"
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            if let ItemController = segue.destination as? ItemController {
                ItemController.selectedCategory = selectedCategory
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        let date = itemArray[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MMM, HH:mm"
        cell.detailTextLabel?.text = "Category: " + itemArray[indexPath.row].category! + " | Due Date: " + formatter.string(from: date!)
                
        return cell
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
 
        // Filterung: Name der parentCategory MIT Name der selectedCategory
        //request.predicate = NSPredicate(format: "category MATCHES %@", selectedCategory!)
 
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}
