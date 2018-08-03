//
//  Person.swift
//  names-to-faces
//
//  Created by Leo Liu on 7/25/18.
//  Copyright © 2018 hungryforcookies. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String
    var imageName: String

    init(name: String, imageName: String){
        self.name = name
        self.imageName = imageName
    }
}
