//
//  Person.swift
//  names-to-faces
//
//  Created by Leo Liu on 7/25/18.
//  Copyright © 2018 hungryforcookies. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    //conforming to NSCoding
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        imageName = aDecoder.decodeObject(forKey: "imageName") as! String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(imageName, forKey: "imageName")
    }
    
    var name: String
    var imageName: String

    init(name: String, imageName: String){
        self.name = name
        self.imageName = imageName
    }
}
