//
//  detailViewController.swift
//  WEEK3
//
//  Created by Yuchen Zhou on 9/20/16.
//  Copyright © 2016 Duke University. All rights reserved.
//
//  This is the controller of Detail View

import UIKit

class detailViewController: UIViewController, SecondViewControllerDelegate {
    var item: Item!
    var number: Int!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var personalInfo: UILabel!
    @IBOutlet weak var detailText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailInfo()
        personalInfo.textAlignment = NSTextAlignment(rawValue: 0)!
        personalInfo.lineBreakMode = NSLineBreakMode(rawValue: 0)!
        personalInfo.numberOfLines = 0
    }
    
    // load information from selected item passing from groupView
    func loadDetailInfo() {
        
        imageView.image = item.image
        firstName.text = item.firstName
        lastName.text = item.lastName
        personalInfo.text = "This is \(item.firstName!) \(item.lastName!)'s info."
        detailText.text = "Greetings from \(item.firstName!) \(item.lastName!)! My NetID is \(item.netID!).\n"
        if item.genderBool == true {
            detailText.text.append("I'm a male student.\n")
        }
        else {
            detailText.text.append("I'm a female student.\n")
        }
        if let height = item.heightLabel , height != "Height" {
            detailText.text.append("I'm \(height) tall.\n")
        }
        if let city = item.cityText , city != "" {
            detailText.text.append("I'm from \(city).\n")
        }
        switch item.status {
        case .bs:
            detailText.text.append("I'm currently an undergraduate student.\n")
        case .ms:
            detailText.text.append("I'm currently a graduate student, pursuing M.S Degree.\n")
        case .meng:
            detailText.text.append("I'm currently a graduate student, pursuing Meng Degree.\n")
        case .phD:
            detailText.text.append("I'm currently a PhD student.\n")
        default:
            break
        }
        
        /*
         if let degree = item.degree where degree != "" {
         detailText.text.appendContentsOf("I'm working on \(degree) degree.\n")
         }
         */
        if let code = item.codingLanguage , code != "" {
            detailText.text.append("I program with \(code).\n")
        }
        if let hobby = item.hobbyText , hobby != "" {
            detailText.text.append("I like to \(hobby).\n")
        }
    }
    
    // Prepare for edit current person's info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditInfo" {
            let dest:addViewController = segue.destination as! addViewController
            dest.item = item
            dest.number = number
        }
    }
    
    // Present Animation of SecondViewController
    @IBAction func doPresent(_ sender:AnyObject?) {
        let svc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        svc.data = "String passed from first VC to second VC" as AnyObject?
        svc.delegate = self
        netID = item.netID
        svc.hobby = item.hobbyText
        
        let which = 4
        switch which {
            //case 1: break // showing that .CoverVertical is the default
            //case 2: svc.modalTransitionStyle = .CoverVertical
        //case 3: svc.modalTransitionStyle = .CrossDissolve
        case 4: svc.modalTransitionStyle = .partialCurl
        self.view.window!.backgroundColor = UIColor.white
            //case 5: svc.modalTransitionStyle = .FlipHorizontal
        //self.view.window!.backgroundColor = UIColor.greenColor()
        default: break
        }
        
        let which2 = 1
        switch which2 {
        case 1: break // showing that .FullScreen is the default
            //case 2: svc.modalPresentationStyle = .FullScreen
            //case 3: svc.modalPresentationStyle = .PageSheet
            //case 4: svc.modalPresentationStyle = .FormSheet
            //case 5: svc.modalPresentationStyle = .OverFullScreen
        //svc.view.alpha = 0.5 // just to prove that it's working
        default: break
        }
        
        self.present(svc, animated:true, completion:nil)
    }
    
    // show data passed back
    func acceptData(_ data:AnyObject!) {
        //print(data)
    }
}
