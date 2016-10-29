//
//  addViewController.swift
//  WEEK3
//
//  Created by Yuchen Zhou on 9/20/16.
//  Copyright © 2016 Duke University. All rights reserved.
//
//  This is the controller of Edit View

import UIKit

class addViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var netID: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightSlide: UISlider!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var cityText: UITextField!
    //@IBOutlet weak var degree: UITextField!
    @IBOutlet weak var codingLanguage: UITextField!
    @IBOutlet weak var hobbyText: UITextField!
    
    var statusPicker: UIPickerView!
    let statusViewController = StatusPickerController()
    
    var item: Item!
    var number: Int?  // Optional number is for deciding which person's info is being edited or it's a new adding(nil)
    var y: CGFloat = 0 // How many pixels the view should move up when keyboard pops up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add event handlers for view rising-up or falling-down when keyboard pops up
        cityText.addTarget(self, action: #selector(addViewController.viewRaiseUp(_:)), for: .editingDidBegin)
        cityText.addTarget(self, action: #selector(addViewController.viewFallDown(_:)), for: .editingDidEnd)
        //degree.addTarget(self, action: #selector(addViewController.viewRaiseUp(_:)), forControlEvents: .EditingDidBegin)
        //degree.addTarget(self, action: #selector(addViewController.viewFallDown(_:)), forControlEvents: .EditingDidEnd)
        codingLanguage.addTarget(self, action: #selector(addViewController.viewRaiseUp(_:)), for: .editingDidBegin)
        codingLanguage.addTarget(self, action: #selector(addViewController.viewFallDown(_:)), for: .editingDidEnd)
        hobbyText.addTarget(self, action: #selector(addViewController.viewRaiseUp(_:)), for: .editingDidBegin)
        hobbyText.addTarget(self, action: #selector(addViewController.viewFallDown(_:)), for: .editingDidEnd)
        genderSwitch.addTarget(self, action: #selector(addViewController.switched(_:)), for: .touchUpInside)
        heightSlide.addTarget(self, action: #selector(addViewController.slided(_:)), for: .valueChanged)
        
        // Set degree picker
        statusPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        statusPicker.center = CGPoint(x: 105, y: 380)
        statusPicker.delegate = statusViewController
        statusPicker.dataSource = statusViewController
        self.addChildViewController(statusViewController)
        self.view.addSubview(statusPicker)
        
        // IF number is not nil, load info from passing-in item
        if let _:Int = number {
            loadDetailInfo()
        }
    }
    
    func loadDetailInfo() {
        imageView.image = item.image
        firstName.text = item.firstName
        lastName.text = item.lastName
        netID.text = item.netID
        genderLabel.text = item.genderLabel
        heightLabel.text = item.heightLabel
        if item.genderLabel == "female" {
            genderSwitch.isOn = false
        }
        else {
            genderSwitch.isOn = true
        }
        cityText.text = item.cityText
        //degree.text = item.degree
        codingLanguage.text = item.codingLanguage
        hobbyText.text = item.hobbyText
        
        let status = item.status
        if status == .select {
            statusPicker.selectRow(0, inComponent: 0, animated: true)
        }
        else if status == .bs {
            statusPicker.selectRow(1, inComponent: 0, animated: true)
        }
        else if status == .ms {
            statusPicker.selectRow(2, inComponent: 0, animated: true)
        }
        else if status == .meng  {
            statusPicker.selectRow(3, inComponent: 0, animated: true)
        }
        else {
            statusPicker.selectRow(4, inComponent: 0, animated: true)
        }
        statusViewController.setValue(item.status)
    }
    
    // For view rising up
    func viewRaiseUp(_ sender: UITextField!) {
        if y == 0 {
            y = 130
            self.view.bounds.origin.y += y
            self.view.layoutIfNeeded()
        }
    }
    
    // For view dropping down
    func viewFallDown(_ sender: UITextField!) {
        if y == 130 {
            self.view.bounds.origin.y -= y
            self.view.layoutIfNeeded()
            y = 0
        }
    }
    
    // Switch handler
    func switched(_ sender: UISwitch!) {
        if sender.isOn {
            genderLabel.text = "male"
        }
        else {
            genderLabel.text = "female"
        }
    }
    
    // Slider handler
    func slided(_ sender: UISlider) {
        heightLabel.text = "\((Int)((sender.value * 150 + 100)/30.48))"
        heightLabel.text?.append("\'")
        heightLabel.text?.append("\((Int)(((sender.value * 150 + 100).truncatingRemainder(dividingBy: 30.48))/2.54))")
        heightLabel.text?.append("\"")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let firstName = firstName.text, let lastName = lastName.text, let netID = netID.text, let image = imageView.image {
            if self.firstName.text != "" && self.lastName.text != "" && self.netID.text != "" {
                item = Item(image: image, firstName: firstName, lastName: lastName, netID: netID, genderLabel: genderLabel.text, heightLabel: heightLabel.text, cityText: cityText.text, status: statusViewController.getValue(), codingLanguage: codingLanguage.text, hobbyText: hobbyText.text)
            }
                // Pop up an 2s' alert
            else {
                let alert = UIAlertController(title: "Warning", message: "Lack of name, NetID or photo", preferredStyle: .alert)
                present(alert, animated: true, completion: {(action) -> Void in sleep(2)})
            }
        }
        else {
            let alert = UIAlertController(title: "Warning", message: "Lack of name, NetID or photo", preferredStyle: .alert)
            present(alert, animated: true, completion: {(action) -> Void in sleep(2)})
        }
    }
    
    // Finish picking images
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    // Pop up image-resource selector, initialize camera or album
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        let title: String = "Edit Photo"
        let message: String = ""
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancel)
        let take = UIAlertAction(title: "Take Photo", style: .default, handler: {(action) -> Void in imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            self.present(imagePicker, animated: true, completion: nil)})
        ac.addAction(take)
        let choose = UIAlertAction(title: "Choose from Album", style: .default, handler:{(action) -> Void in
            imagePicker.sourceType = .savedPhotosAlbum
            self.present(imagePicker, animated: true, completion: nil)})
        ac.addAction(choose)
        present(ac, animated: true, completion: nil)
    }
    
    // Resign first responder by tapping background
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
