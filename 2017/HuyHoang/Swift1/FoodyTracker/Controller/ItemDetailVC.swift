//
//  ItemDetailVC.swift
//  FoodyTracker
//
//  Created by HHumorous on 9/18/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

import UIKit
import os.log

class ItemDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ratingStar: RatingControl!
    @IBOutlet weak var foodNameTF: UITextField!
    
    @IBAction func defaultNamePressedButton(_ sender: Any) {
        
        foodNameTF.text = "Delicious Meal"
        
    }
    
    @IBOutlet weak var imageFood: UIImageView!
    
    @IBOutlet weak var savePressedButton: UIBarButtonItem!
    
    var imagePicker: UIImagePickerController!
    
    var food: Foods?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageFood.isUserInteractionEnabled = true
        imageFood.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImage)))
        
        foodNameTF.delegate = self
        
        if let meal = food {
            navigationItem.title = meal.name
            foodNameTF.text = meal.name
            imageFood.image = meal.photo
            ratingStar.rating = meal.rating
        }

        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        savePressedButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        foodNameTF.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = foodNameTF.text
    }
    
    //MARK: UIImagePickerDelegate
    
    @objc func addImage() {
        
        let alert = UIAlertController(title: "Notice", message: "Choose a photo for your meals!", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Take a photo", style: UIAlertActionStyle.default, handler: {action in self.takePhoto()}))
        alert.addAction(UIAlertAction(title: "From Photo Library", style: UIAlertActionStyle.default, handler: {action in self.openLibrary()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func takePhoto() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker!.allowsEditing = true
            imagePicker!.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker!.cameraCaptureMode = .photo
            present(imagePicker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openLibrary() {
        foodNameTF.resignFirstResponder()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageFood.image = img
        } else {
            print("Something was wrong")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Dimiss view
    @IBAction func cancelPressedButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)

        guard let button = sender as? UIBarButtonItem, button == savePressedButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = foodNameTF.text ?? ""
        let photo = imageFood.image
        let rating = ratingStar.rating

        food = Foods(name: name, photo: photo, rating: rating)
    }

    private func updateSaveButtonState() {
        
        let text = foodNameTF.text ?? ""
        savePressedButton.isEnabled = !text.isEmpty
    }
}
