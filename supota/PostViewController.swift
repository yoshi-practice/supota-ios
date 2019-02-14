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

    @IBOutlet var TextView:UITextView!
    @IBOutlet var ImageButton:UIButton!
    //
    @IBOutlet var FirstImageView:UIImageView!
    @IBOutlet var SecoundImageView:UIImageView!
    @IBOutlet var ThaadImageview:UIImageView!
    let ref = Database.database().reference()
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
        if images.count < 2{
            
            
        }else if images.count == 2{
            ThaadImageview.image = image
            
        }else if images.count == 1{
            SecoundImageView.image = image
            
        }else{
            FirstImageView.image = image
        }
        
        self.dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    @IBAction func postBtn(){
        var imagebool:String = "none"
        if images != []{
            imagebool = "init"
            for i in 0..<images.count {
//                timeline().uploadimage(data: UIImagePNGRepresentation(images[i])!, title: String(i), path: timestamp)
            }
        }else{
            imagebool = "empty"

        }
        let timeInterval = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timeInterval)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let timestamp = formatter.string(from: time as Date)
        ref.child("timeline").childByAutoId().setValue(["UID":"uid","content":TextView.text!,"image":imagebool,"likes":"0","timestamp":timestamp])
        
    }
    

}
