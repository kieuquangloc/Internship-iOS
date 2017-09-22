//
//  ViewController.swift
//  FoodyTracker
//
//  Created by HHumorous on 9/18/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mealTableView: UITableView!

    var foods = [Foods]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedFoods = loadFoods() {
            foods += savedFoods
        }
        else {
            loadSampleMeals()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ItemCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemCell  else {
            fatalError("The dequeued cell is not an instance of ItemCell.")
        }

        let food = foods[indexPath.row]
        
        cell.titleFood.text = food.name
        cell.imageFood.image = food.photo
        cell.ratingStar.rating = food.rating
        cell.ratingStar.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let itemDetailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        itemDetailVC.food = foods[indexPath.row];
        
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.remove(at: indexPath.row)
            saveFoods()
            mealTableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           
        }
    }

    @IBAction func addMealButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let itemDetailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ItemDetailVC, let food = sourceViewController.food {
            
            if let selectedIndexPath = mealTableView.indexPathForSelectedRow {
                foods[selectedIndexPath.row] = food
                mealTableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: foods.count, section: 0)
                
                foods.append(food)
                mealTableView.insertRows(at: [newIndexPath], with: .automatic)
            }

            saveFoods()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Foods(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Foods(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Foods(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        
        foods += [meal1, meal2, meal3]
    }
    
    private func saveFoods() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(foods, toFile: Foods.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Foods successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save foods...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadFoods() -> [Foods]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Foods.ArchiveURL.path) as? [Foods]
    }
    
}

