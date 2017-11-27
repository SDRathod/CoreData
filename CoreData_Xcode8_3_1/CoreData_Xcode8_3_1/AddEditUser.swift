//
//  AddEditUser.swift
//  CoreData_Xcode8_3_1
//
//  Created by Samir Rathod on 26/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit
import CoreData

class AddEditUser: UIViewController {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtViewAddress: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gestTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userTepGesture))
        imgUser.addGestureRecognizer(gestTap)
        imgUser.isUserInteractionEnabled = true
        
        imgUser.layer.borderColor = UIColor.blue.cgColor
        imgUser.layer.borderWidth = 1
        
        txtViewAddress.layer.borderColor = UIColor.black.cgColor
        txtViewAddress.layer.borderWidth = 1
        txtViewAddress.layer.cornerRadius = 5
        
        txtViewAddress.layer.cornerRadius = 10
        self.createDirectory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func userTepGesture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnSaveClick(_ sender: Any) {
        
       // saveImageDocumentDirectory()
        
        guard self.txtName.text != "" else {
            return
        }
        
        guard self.txtEmail.text != "" else {
            return
        }
        
        guard self.txtContact.text != "" else {
            return
        }
        
        guard self.txtViewAddress.text != "" else {
            return
        }
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        
        let managedContext = appdelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        //3
        person.setValue(self.txtName.text, forKey: "name")
        person.setValue(self.txtEmail.text, forKey: "email")
        person.setValue(self.txtContact.text, forKey: "contact")
        person.setValue(self.txtViewAddress.text, forKey: "address")
        person.setValue(self.saveImageDocumentDirectory(), forKey: "userProfile")
        
        //4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save, \(error),\(error.userInfo)")
        }
    }
    // MARK: -  Save and Get Image from DocumentDir
    
    func saveImageDocumentDirectory() -> String{
        let fileManager = FileManager.default
        let SetFileNmae = generateUniqueFilename(myFileName: self.txtEmail.text! + txtName.text!)
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("PhotoDirectory/\(SetFileNmae)")
       // let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(self.imgUser.image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        return SetFileNmae
    }
    
    func getImage(imgName : String){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imgName)
        if fileManager.fileExists(atPath: imagePAth){
            self.imgUser.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }
    
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("PhotoDirectory")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = (paths[0] as NSString).appendingPathComponent("PhotoDirectory")
        return documentsDirectory
    }
    
    func generateUniqueFilename (myFileName: String) -> String {
        
        let guid = ProcessInfo.processInfo.globallyUniqueString
        let uniqueFileName = ("\(myFileName)_\(guid).jpg")
        
        print("uniqueFileName: \(uniqueFileName)")
        
        return uniqueFileName
    }
    
}

extension AddEditUser : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // use the image
        self.imgUser.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


