//
//  item.swift
//  WEEK3
//
//  Created by Yuchen Zhou on 9/20/16.
//  Copyright © 2016 Duke University. All rights reserved.
//
//  Class for person's info data model

import UIKit

// Picker view data model
enum Status {
    case other, bs, ms, meng, phD
    func description() -> String {
        switch self {
        case .other:
            return "Other"
        case .bs:
            return "B.S"
        case .ms:
            return "M.S"
        case .meng:
            return "Meng"
        case .phD:
            return "PhD"
        }
    }
}

class Item: NSObject, NSCoding {
    var image: UIImage!
    var firstName: String!
    var lastName: String!
    var netID: String!
    var genderBool: Bool!
    var heightLabel: String?
    var cityText: String?
    //var degree: String?
    var status: Status
    var codingLanguage: String?
    var hobbyText: String?
    
    struct propertyKey {
        static let imageKey = "image"
        static let firstNameKey = "firstName"
        static let lastNameKey = "lastName"
        static let netIDKey = "netID"
        static let genderBoolKey = "genderBool"
        static let heightLabelKey = "heightLabel"
        static let cityTextKey = "cityText"
        //static let degreeKey = "degree"
        static let statusKey = "status"
        static let codingLanguageKey = "codingLanguage"
        static let hobbyTextKey = "hobbyText"
    }
    
    // Encode data when saving to file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: propertyKey.firstNameKey)
        aCoder.encode(lastName, forKey: propertyKey.lastNameKey)
        aCoder.encode(netID, forKey: propertyKey.netIDKey)
        aCoder.encode(genderBool, forKey: propertyKey.genderBoolKey)
        aCoder.encode(heightLabel, forKey: propertyKey.heightLabelKey)
        aCoder.encode(cityText, forKey: propertyKey.cityTextKey)
        //aCoder.encodeObject(degree, forKey: propertyKey.degreeKey)
        aCoder.encode(status.description(), forKey: propertyKey.statusKey)
        aCoder.encode(codingLanguage, forKey: propertyKey.codingLanguageKey)
        aCoder.encode(hobbyText, forKey: propertyKey.hobbyTextKey)
        aCoder.encode(image, forKey: propertyKey.imageKey)
    }
    
    init?(image: UIImage, firstName: String, lastName: String, netID: String, genderBool: Bool, heightLabel: String?, cityText: String?, status: Status, codingLanguage: String?, hobbyText: String?) {
        
        self.image = image
        self.firstName = firstName
        self.lastName = lastName
        self.netID = netID
        self.genderBool = genderBool
        self.heightLabel = heightLabel
        self.cityText = cityText
        //self.degree = degree
        self.status = status
        self.codingLanguage = codingLanguage
        self.hobbyText = hobbyText
        if let _ = self.firstName, let _ = self.lastName, let _ = self.netID, let _ = self.image {
        }
        else {
            return nil
        }
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let firstName = aDecoder.decodeObject(forKey: propertyKey.firstNameKey) as! String
        let lastName = aDecoder.decodeObject(forKey: propertyKey.lastNameKey) as! String
        let netID = aDecoder.decodeObject(forKey: propertyKey.netIDKey) as! String
        let genderBool = aDecoder.decodeObject(forKey: propertyKey.genderBoolKey) as! Bool
        let heightLabel = aDecoder.decodeObject(forKey: propertyKey.heightLabelKey) as? String
        let cityText = aDecoder.decodeObject(forKey: propertyKey.cityTextKey) as? String
        //let degree = aDecoder.decodeObjectForKey(propertyKey.degreeKey) as? String
        let codingLanguage = aDecoder.decodeObject(forKey: propertyKey.codingLanguageKey) as? String
        let hobbyText = aDecoder.decodeObject(forKey: propertyKey.hobbyTextKey) as? String
        let image = aDecoder.decodeObject(forKey: propertyKey.imageKey) as! UIImage
        let statusStr = aDecoder.decodeObject(forKey: propertyKey.statusKey) as! String
        let status: Status
        switch statusStr {
        case "B.S":
            status = .bs
        case "M.S":
            status = .ms
        case "Meng":
            status = .meng
        case "PhD":
            status = .phD
        default:
            status = .other
        }
        self.init(image: image, firstName: firstName, lastName: lastName, netID: netID, genderBool: genderBool, heightLabel: heightLabel, cityText: cityText, status:status, codingLanguage: codingLanguage, hobbyText: hobbyText)
    }
    
    // Set data save path and file name
    static let documentsDirectory = FileManager.default.urls(for: . documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = documentsDirectory.appendingPathComponent("items")
    
}
