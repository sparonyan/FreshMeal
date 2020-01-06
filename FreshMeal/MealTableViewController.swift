//
//  MealTableViewController.swift
//  FreshMeal
//
//  Created by Satine Paronyan on 1/3/20.
//  Copyright © 2020 Satine Paronyan. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleMeals()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        
        
        if meal.prepHour == nil && meal.prepMins == nil {
            cell.prepLabel.text = "-"
        }
        else {
            var prep = ""
            if meal.prepHour == nil {
                prep += "0"
            } else {
                prep += "\(String(describing: meal.prepHour ?? 0))"
            }
            
            prep += ":"
            if meal.prepMins == nil {
                prep += "00"
            } else {
                 prep += "\(String(describing: meal.prepMins ?? 0))"
            }

            cell.prepLabel.text = prep
        }
        
        
        if meal.totalHour == nil && meal.totalMins == nil {
            cell.totalLabel.text = "-"
        }
        else {
            var total = ""
            if meal.totalHour == nil {
                total += "0"
            } else {
                total += "\(String(describing: meal.totalHour ?? 0))"
            }
            
            total += ":"
            if meal.prepMins == nil {
                total += "00"
            } else {
                 total += "\(String(describing: meal.totalMins ?? 0))"
            }

            cell.totalLabel.text = total
        }
        
        
        if meal.calories == nil {
            cell.caloriesLabel.text = "-"
        }
        else {
            let calory = "\(String(describing: meal.calories ?? 0))"
            cell.caloriesLabel.text = calory
        }
        return cell
    }

   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    //MARK: Private Methods
     
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        /*
         init?(name: String, photo: UIImage?, serving: Int?, prepHour: Int?, prepMins: Int?,
         totalHour: Int?, totalMins: Int?, calories: Int?, ingregients: String, preparation: String?) {
         */
        let ingr1 = "1 cumber\n1 tomato\n1bell pepper\n1 cup shredded cabbage\n"
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, serving: 4, prepHour: 0, prepMins: 25, totalHour: 0, totalMins: 45, calories: 783, ingregients: ingr1, preparation: "") else {
            fatalError("Unable to instantiate meal1")
        }
         
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, serving: 4, prepHour: 0, prepMins: 19, totalHour: 0, totalMins: 54, calories: 861, ingregients: ingr1, preparation: "") else {
            fatalError("Unable to instantiate meal2")
        }
         
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, serving: 4, prepHour: 0, prepMins: 23, totalHour: 1, totalMins: 12, calories: 1100, ingregients: ingr1, preparation: "") else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3]
        
        
    }
}
