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

    }


    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        
        //saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //updateSaveButtonState()
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
    
}

