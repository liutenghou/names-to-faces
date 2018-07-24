//
//  ViewController.swift
//  names-to-faces
//
//  Created by Leo Liu on 7/23/18.
//  Copyright © 2018 hungryforcookies. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: collection view methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PersonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCollectionViewCell
        return cell
    }
}

