//
//  ViewController.swift
//  parse chat
//
//  Created by fer on 2/21/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

  @IBOutlet weak var emailBox: UITextField!
  @IBOutlet weak var passwordBox: UITextField!
  
  let alertController = UIAlertController(title: "Error", message: "Please enter a valid email and password.", preferredStyle: .alert)
  let alertController1 = UIAlertController(title: "Error", message: "Incorrect email/password.", preferredStyle: .alert)
  let alertController2 = UIAlertController(title: "Error", message: "An account with this username already exists.", preferredStyle: .alert)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let cancel = UIAlertAction(title: "Got it.", style: .cancel) { (action) in
    }
    alertController.addAction(cancel)
    alertController1.addAction(cancel)
    alertController2.addAction(cancel)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func signUp(_ sender: UIButton) {
    if emailBox.text == "" || passwordBox.text == ""
    {
      self.present(alertController, animated: true) {
        
      }
      emailBox.text = ""
      passwordBox.text = ""
    }
    else
    {
      let user = PFUser()
      user.username = emailBox.text
      user.password = passwordBox.text
      
      user.signUpInBackground() {
        (succeeded: Bool?, error: Error?) -> Void in
          if !user.isNew {
            self.present(self.alertController2, animated: true)
          }
          else {
            self.performSegue(withIdentifier: "success", sender: nil)
          }
        }
      }
    }

  @IBAction func logIn(_ sender: UIButton) {
    
    PFUser.logInWithUsername(inBackground: emailBox.text!, password: passwordBox.text!){ (user: PFUser?, error: Error?) in
      if user != nil
      {
        self.performSegue(withIdentifier: "success", sender: nil)
      }
      else {
        self.present(self.alertController1, animated: true)
        self.emailBox.text = ""
        self.passwordBox.text = ""
      }
    }
  }
  
  // dismisses keyboard
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

