//
//  LoginViewController.swift
//  StepCount
//
//  Created by Ryan  Gunn on 2/7/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var passwordTextField: UITextField!
    let ref = Firebase(url: "https://healthkitapp.firebaseio.com")
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tap = UITapGestureRecognizer(target: self, action: "dimissKeyboard")
        self.view .addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }


    @IBAction func loginButtonTapped(sender: UIButton) {
        login()
    }

    @IBAction func signUpButtonTapped(sender: UIButton) {
        signUp()
    }


    func login() {
        ref.authUser(emailTextField.text!, password: passwordTextField.text) { (error, authData) -> Void in
            if error != nil {
                print(error.localizedDescription)
            }else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                })
            }
        }

    }

    func dimissKeyboard() {
        self.view.endEditing(true)

    }
    func signUp() {

        self.ref.createUser(emailTextField.text, password: passwordTextField.text) { (error: NSError!) in

            if error != nil {
                print(error.localizedDescription)
            } else {


                self.ref.authUser(self.emailTextField.text, password: self.passwordTextField.text, withCompletionBlock: { (error, auth) in
                    if error != nil {

                    }else {

                        let standardDefaults = NSUserDefaults.standardUserDefaults()
                        standardDefaults.setObject(auth.uid, forKey: "currentUserUID")

                        let newUserName = [ "userID":auth.uid, "friendsCount":0, "userEmail":self.emailTextField.text!, "steps": 0, "wins": 0, "loses": 0]

                        self.ref.childByAppendingPath("users").childByAppendingPath(auth.uid).setValue(newUserName)

                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.performSegueWithIdentifier("loginSegue", sender: self)
                        })
                    }
                    
                    
                })
            }
            
        }
        
    }

}
