//
//  Meal.swift
//  FreshMeal
//
//  Created by Satine Paronyan on 1/3/20.
//  Copyright © 2020 Satine Paronyan. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    //var rating: Int
    var serving: Int?
    var prepHour: Int?
    var prepMins: Int?
    var totalHour: Int?
    var totalMins: Int?
    var calories: Int?
    var ingredients: String
    var preparation: String?
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        //static let rating = "rating"
        static let serving = "serving"
        
        static let prepHour = "prepHour"
        static let prepMins = "prepMins"
        
        static let totalHour = "totalHour"
        static let totalMins = "totalMins"
        
        static let calories = "calories"
        static let ingredients = "ingredients"
        static let preparation = "preparation"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, serving: Int?, prepHour: Int?, prepMins: Int?,
          totalHour: Int?, totalMins: Int?, calories: Int?, ingregients: String, preparation: String?) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
         
        // The ingredients must be not empty
        guard (!ingregients.isEmpty) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.serving = serving
        self.prepHour = prepHour
        self.prepMins = prepMins
        self.totalHour = totalHour
        self.calories = calories
        self.ingredients = ingregients
        self.preparation = preparation
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(serving, forKey: PropertyKey.serving)
        aCoder.encode(prepHour, forKey: PropertyKey.prepHour)
        aCoder.encode(prepMins, forKey: PropertyKey.prepMins)
        aCoder.encode(totalHour, forKey: PropertyKey.totalHour)
        aCoder.encode(totalMins, forKey: PropertyKey.totalMins)
        aCoder.encode(calories, forKey: PropertyKey.calories)
        aCoder.encode(ingredients, forKey: PropertyKey.ingredients)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The ingredients are required. If we cannot decode ingredients string, the initializer should fail.
        guard let ingredients = aDecoder.decodeObject(forKey: PropertyKey.ingredients) as? String else {
            os_log("Unable to decode the ingredients for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let serving = aDecoder.decodeObject(forKey: PropertyKey.serving) as? Int
        
        let prepHour = aDecoder.decodeObject(forKey: PropertyKey.prepHour) as? Int
        let prepMins = aDecoder.decodeObject(forKey: PropertyKey.prepMins) as? Int
        
        let totalHour = aDecoder.decodeObject(forKey: PropertyKey.totalHour) as? Int
        let totalMins = aDecoder.decodeObject(forKey: PropertyKey.totalMins) as? Int
        
        let calories = aDecoder.decodeObject(forKey: PropertyKey.calories) as? Int
        
        let preparation = aDecoder.decodeObject(forKey: PropertyKey.preparation) as? String
        //let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, serving: serving, prepHour: prepHour, prepMins: prepMins,
                  totalHour: totalHour, totalMins: totalMins, calories: calories, ingregients: ingredients,
                  preparation: preparation)
    }
    
    
}

