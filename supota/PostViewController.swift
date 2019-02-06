//
//  PostViewController.swift
//  supota
//
//  Created by 柳川優稀 on 2019/02/06.
//  Copyright © 2019年 柳川優稀. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let uid = Auth.auth().currentUser

    //    投稿処理

    //  ストレージアップロード
    
    
    @IBOutlet var TextView:UITextView!
    @IBOutlet var ImageButton:UIButton!
    var images:[UIImage] = []
   @IBOutlet var ImageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func toAlbum(){
        //     ImagePickerを開く
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //    ImagePickerからカメラロールの画像を選択したときの処理
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(image)
        
        self.dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    @IBAction func postBtn(){
        let timestamp:String = "\(ServerValue.timestamp())"
        var imagebool:String = "none"
        if images != []{
            imagebool = "init"
            for i in 0..<images.count {
                timeline().uploadimage(data: UIImagePNGRepresentation(images[i])!, title: String(i), path: timestamp)
            }
        }
        timeline().post(content: TextView.text ,image: imagebool ,timestamp: timestamp)
        
    }
    

}
