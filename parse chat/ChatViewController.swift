//
//  ChatViewController.swift
//  parse chat
//
//  Created by fer on 2/23/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
  
  @IBOutlet weak var messageTable: UITableView!
  @IBOutlet weak var messageBox: UITextView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
    
  @IBAction func sendMessage(_ sender: UIButton) {
    let message = PFObject(className: "Message")
    
    if messageBox.text != "" {
      message["text"] = messageBox.text
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
