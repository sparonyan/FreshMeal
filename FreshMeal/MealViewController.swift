//
//  MealViewController.swift
//  FreshMeal
//
//  Created by Satine Paronyan on 1/2/20.
//  Copyright © 2020 Satine Paronyan. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,
                UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var servingTextField: UITextField!
    @IBOutlet weak var prepTimeHourTextField: UITextField!
    @IBOutlet weak var prepTimeMinsTextField: UITextField!
    @IBOutlet weak var totalTimeHourTextField: UITextField!
    @IBOutlet weak var totalTimeMinsTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var preparationTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Handle Text Field's user input though delegate callbacks.
        nameTextField.delegate = self
        
        servingTextField.delegate = self
        
        prepTimeHourTextField.delegate = self
        prepTimeMinsTextField.delegate = self
        
        totalTimeHourTextField.delegate = self
        totalTimeMinsTextField.delegate = self
        
        caloriesTextField.delegate = self
        ingredientsTextView.delegate = self as? UITextViewDelegate
        prepTimeMinsTextField.delegate = self

        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            servingTextField.text = "\(String(describing: meal.serving))"
            prepTimeHourTextField.text = "\(String(describing: meal.prepHour))"
            prepTimeMinsTextField.text = "\(String(describing: meal.prepMins))"
            totalTimeHourTextField.text = "\(String(describing: meal.totalHour))"
            totalTimeMinsTextField.text = "\(String(describing: meal.totalMins))"
            caloriesTextField.text = "\(String(describing: meal.calories))"
            ingredientsTextView.text = meal.ingredients
            preparationTextView.text = meal.preparation
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }


    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
       
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let serving = Int(servingTextField.text ?? "") ?? 0
        let prepHour = Int(prepTimeHourTextField.text ?? "") ?? 0
        let prepMins = Int(prepTimeMinsTextField.text ?? "") ?? 0
        let totalHour = Int(totalTimeHourTextField.text ?? "") ?? 0
        let totalMins = Int(totalTimeMinsTextField.text ?? "") ?? 0
        let calories = Int(caloriesTextField.text ?? "") ?? 0
        let ingredients = ingredientsTextView.text ?? ""
        let preparation = preparationTextView.text ?? ""
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        /*
         init?(name: String, photo: UIImage?, serving: Int?, prepHour: Int?, prepMins: Int?,
         totalHour: Int?, totalMins: Int?, calories: Int?, ingregients: String, preparation: String?) {
         */
        meal = Meal(name: name, photo: photo, serving: serving, prepHour: prepHour, prepMins: prepMins,
                    totalHour: totalHour, totalMins: totalMins, calories: calories, ingregients: ingredients,
                    preparation: preparation)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        servingTextField.resignFirstResponder()
        prepTimeHourTextField.resignFirstResponder()
        prepTimeMinsTextField.resignFirstResponder()
        totalTimeHourTextField.resignFirstResponder()
        totalTimeMinsTextField.resignFirstResponder()
        caloriesTextField.resignFirstResponder()
        ingredientsTextView.resignFirstResponder()
        prepTimeMinsTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

