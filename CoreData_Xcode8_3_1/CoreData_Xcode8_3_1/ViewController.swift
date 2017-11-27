//
//  ViewController.swift
//  CoreData_Xcode8_3_1
//
//  Created by Samir Rathod on 26/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tblObj: UITableView!
    var userList : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   tblObj.register(UserListCell.self, forCellReuseIdentifier: "UserListCell")
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tblObj.rowHeight = UITableViewAutomaticDimension
        self.tblObj.estimatedRowHeight = 100
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // get DB using managedContext
        let managedContext = appdelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest  = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            userList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("could not fetch record.\(error.userInfo)")
        }
        self.tblObj.reloadData()
        
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let addViewObj : AddEditUser = segue.destination as! AddEditUser
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        let objectM = self.userList[indexPath.row]
        
        cell.lblName?.text =  objectM.value(forKey: "name") as? String
        cell.lblContact?.text = objectM.value(forKey: "contact") as?  String
        cell.lblAddress?.text = objectM.value(forKey: "address") as? String
        print(objectM.value(forKey: "name") as? String ?? "dd")
        cell.imgUserPhoto.image = UIImage(contentsOfFile: Singleton.sharedSingleton.getImage(imgName: objectM.value(forKey: "userProfile") as! String))
        //cell.lblContact?.text = userList?v
        return cell;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .blue
        
        return [share, favorite, more]
    }
}
