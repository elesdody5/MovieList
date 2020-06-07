//
//  AddViewController.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 3/26/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
import CoreData

class AddViewController :UITableViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    
  
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var imgTextField: UITextField!
    @IBOutlet weak var generTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    var addDelegete:AddDelegation?
    var movie:Movie?
    var appDeleate:AppDelegate?
    var mangedConetxt:NSManagedObjectContext?
    private var presenter:AddPresenterProtcol?
    override func viewDidLoad() {
        super.viewDidLoad()
        appDeleate = (UIApplication.shared.delegate as!AppDelegate)
        mangedConetxt = appDeleate!.persistentContainer.viewContext
        presenter=AddPresenter(mangedConetxt: mangedConetxt!)
    }
    

    @IBAction func done(_ sender: UIBarButtonItem) {
        movie = Movie(title: titleTextField.text!, img: imgTextField.text!, rate:Float( ratingTextField.text!) as! Float, realseYear: yearTextField.text!, genr: [generTextField.text!])
       
       
        if presenter!.saveInDatabase(movie:movie) {
            showSuccessfull()
        }
        
    }
    
    @IBAction func pickImage(_ sender: UIButton) {
        let imgPicker :UIImagePickerController=UIImagePickerController()
        imgPicker.delegate=self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated:  true,completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if  let image:UIImage = info[.originalImage] as?UIImage{
            movieImage.image = image
            let imageData:NSData = image.pngData()! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            imgTextField.text=strBase64
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    func showSuccessfull(){
        let alert :UIAlertController=UIAlertController(title: "Added Successfully", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {action in
            self.goToHomeScreeen()
        }))
        self.present(alert, animated:  true,completion: nil)

    }
    func goToHomeScreeen(){
        addDelegete?.addMovie(movie!)
    navigationController?.popViewController(animated: true)
    }
    
   
}
