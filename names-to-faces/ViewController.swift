//
//  ViewController.swift
//  names-to-faces
//
//  Created by Leo Liu on 7/23/18.
//  Copyright © 2018 hungryforcookies. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        //load saved data
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data{
            people = NSKeyedUnarchiver.unarchiveObject(with: savedPeople) as! [Person]
        }
    }
    
    //selector method after clicking add button
    @objc func addNewPerson() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    //MARK: image picker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else{
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80){
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", imageName: imageName)
        people.append(person)
        collectionView?.reloadData()
        save()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //image path helper
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //MARK: collection view methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PersonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCollectionViewCell
        
        //pull out the person from the array
        let person = people[indexPath.item]
        //set the name label correctly
        cell.name.text = person.name
        //set the image from filename
        let imagePath = getDocumentsDirectory().appendingPathComponent(person.imageName)
        cell.imageView.image = UIImage(contentsOfFile: imagePath.path)
        
        //some cell prettying
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //show alert controller when user taps cell, add name
        
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            person.name = newName.text!
            self.collectionView?.reloadData()
            self.save()
        })
        
        present(ac, animated: true)
    }
    
    //MARK: saving
    func save(){
        let savedData = NSKeyedArchiver.archivedData(withRootObject: people)
        let defaults = UserDefaults.standard
        
        defaults.set(savedData, forKey: "people")
    }
}
