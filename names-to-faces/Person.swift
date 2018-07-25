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
    var image: String

    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}
