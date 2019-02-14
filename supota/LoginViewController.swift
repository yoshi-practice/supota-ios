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

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var username:UITextField!
    @IBOutlet var password:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let border = CALayer()
        let width = CGFloat(2.0)

        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: password.frame.size.height - width, width:  password.frame.size.width, height: 1)
        border.borderWidth = width
        password.layer.addSublayer(border)
        let border2 = CALayer()
        
        border2.borderColor = UIColor.gray.cgColor
        border2.frame = CGRect(x: 0, y: password.frame.size.height - width, width:  password.frame.size.width, height: 1)
        border2.borderWidth = width
        username.layer.addSublayer(border2)

        password.delegate = self
        password.isSecureTextEntry = true
        
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
