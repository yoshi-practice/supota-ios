
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
class timeline {
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser



    func post(content:String,image:String){
        ref.child("timeline").childByAutoId().setValue(["UID":uid,"content":content,"images":image,"likes":"0"])
        
    }
    
    func uploadimage(data:Data,title:String,path:String){

        let imagePath = Storage.storage().reference().child("content/\(path)/\(title).png")
      
      imagePath.putData(data, metadata: nil)
        
    }
}
