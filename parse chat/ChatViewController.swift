//
//  ChatViewController.swift
//  parse chat
//
//  Created by fer on 2/23/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit
import Parse

var messages: [PFObject]!

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var messageTable: UITableView!
  @IBOutlet weak var messageBox: UITextView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  
    messageTable.delegate = self
    messageTable.dataSource = self
    messageTable.rowHeight = UITableViewAutomaticDimension
    messageTable.estimatedRowHeight = 45
    
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  // send message function
  @IBAction func sendMessage(_ sender: UIButton) {
    var message = PFObject(className: "Message")
    
    //if messageBox.text != "" {
      message["text"] = messageBox.text!
      message["user"] = PFUser.current()
      
      message.saveInBackground(){
        (succeeded: Bool?, error: Error?) -> Void in
        if error != nil {
          //
        }
        else {
          print("Saved")
          print(self.messageBox.text)
        }
      }
    //}
    //else {
      
    //}
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if messages != nil {
      return messages.count
    }
    else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = messageTable.dequeueReusableCell(withIdentifier: "mesCell") as! MessageViewCell
    let corMes = messages[indexPath.row]
    let realMes = corMes["text"] as! String
    let user = corMes["user"] as! PFUser
    
    if user.username != nil {
      cell.mesLabel.text = "\(user.username!): \(realMes)"
    }
    else {
      cell.mesLabel.text = "\(realMes)"
    }
    
    return cell
  }
  
  func onTimer()
  {
    var query = PFQuery(className: "Message")
    
    query.order(byDescending: "createdAt")
    
    query.includeKey("text")
    query.includeKey("user")
    
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
      if error == nil {
        if let objects = objects {
          messages = objects
        }
      } else {
        //
      }
    }
    messageTable.reloadData()
  }
  
  // dismisses keyboard
  func dismissKeyboard() {
    view.endEditing(true)
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
