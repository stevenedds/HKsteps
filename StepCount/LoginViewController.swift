//
//  LoginViewController.swift
//  StepCount
//
//  Created by Ryan  Gunn on 2/7/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var passwordTextField: UITextField!

    

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
        Backendless.sharedInstance().userService.login(emailTextField.text, password: passwordTextField.text, response: { (user) -> Void in

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("loginSegue", sender: self)
            })
            
            }) { (error) -> Void in
                print(error.message)
        }
    }

    func dimissKeyboard() {
        self.view.endEditing(true)

    }
    func signUp() {

        let user = BackendlessUser()
        user.name = emailTextField.text
        user.password = passwordTextField.text
        Backendless.sharedInstance().userService.registering(user, response: { (user) -> Void in

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("loginSegue", sender: self)
            })
            
            }) { (error) -> Void in
                    print(error.message)
        }
        
    }

}
