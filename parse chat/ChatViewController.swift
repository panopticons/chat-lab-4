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
  
  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
    
  @IBAction func sendMessage(_ sender: UIButton) {
    let message = PFObject(className: "Message")
    
    if messageBox.text != "" {
      message["text"] = messageBox.text
      message["user"] = PFUser.current()
      
      message.saveInBackground(){
        (succeeded: Bool?, error: Error?) -> Void in
        if error != nil {
          
        }
        else {
          print("Saved")
        }
      }
    }
    else {
      
    }
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
    let realMes = corMes["text"]
    let user = corMes["user"] as! PFUser
    cell.mesLabel.text = realMes as! String
    
    return cell
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
