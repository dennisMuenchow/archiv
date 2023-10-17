//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Dennis Münchow on 14.10.23.
//

import UIKit


class CategoryViewController: UIViewController {
    
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
