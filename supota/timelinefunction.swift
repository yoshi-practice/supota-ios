
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
class timeline {
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser



    func post(content:String,image:String,timestamp:String){
        ref.child("timeline").child(timestamp).setValue(["UID":uid,"content":content,"postid":image,"likes":"0","timestamp":timestamp])
        
    }
    func like(postid:String,like:String){
        ref.child(postid).setValue(["likes":like])
    }
    
    func uploadimage(data:Data,title:String,path:String){
        let imagePath = Storage.storage().reference().child("content/\(path)/\(title).png")
        imagePath.putData(data, metadata: nil)
        
    }
}
