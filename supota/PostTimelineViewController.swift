//
//  PostTimelineViewController.swift
//  supota
//
//  Created by 柳川優稀 on 2019/02/14.
//  Copyright © 2019年 柳川優稀. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostTimelineViewController: UIViewController {
    let ref = Database.database().reference()


    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("timeline").childByAutoId().setValue(["UID":"uid","content":"content","postid":"image","likes":"0","timestamp":"timestamp"])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func postBtn(){
        


    }

}
