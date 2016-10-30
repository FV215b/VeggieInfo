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
    var hobbystr: String! = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var netID: UILabel!
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
        name.text = item.name
        netID.text = item.netID
        personalInfo.text = "This is \(item.name) from team \(item.team)."
        detailText.text = "Greetings!\n"
        let gender = item.gender ? "male" : "female"
        detailText.text.append("My name is \(item.name), a \(gender) student from \(item.city). ")
        detailText.text.append("I'm \(item.height) tall. ")
        switch item.status {
        case .bs:
            detailText.text.append("I'm currently an undergraduate student. ")
        case .ms:
            detailText.text.append("I'm currently a graduate student, pursuing M.S Degree. ")
        case .meng:
            detailText.text.append("I'm currently a graduate student, pursuing Meng Degree. ")
        case .phD:
            detailText.text.append("I'm currently a PhD student. ")
        default:
            break
        }
        detailText.text.append("I program with \(item.languages[0]), \(item.languages[1]) and \(item.languages[2]). ")
        detailText.text.append("I like to \(item.hobbies[0]) and \(item.hobbies[1]).")
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
        switch item.netID {
        case "yz333":
            let svc = SecondViewController(nibName: "SecondViewController", bundle: nil)
            //svc.data = "flip from detail page to animation" as AnyObject?
            svc.delegate = self
            
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
        default:
            break
        }
    }
    
    // show data passed back
    func acceptData(_ data:AnyObject!) {
        //print(data)
    }
}
