//
//  LoginViewController.swift
//  supota
//
//  Created by 柳川優稀 on 2019/02/12.
//  Copyright © 2019年 柳川優稀. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet var username:UITextField!
    @IBOutlet var password:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func loginBtn(){
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "success", sender: nil)
                
            }
            
        }
    }
    


}
