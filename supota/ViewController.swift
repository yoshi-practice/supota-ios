
import FirebaseDatabase
import UIKit

class ViewController: UIViewController {
    @IBOutlet var TextFeild:UITextField!
    @IBOutlet var TextView:UITextView!
    var snap: DataSnapshot!
    var ref: DatabaseReference!
    var items: [DataSnapshot] = []
    var useritems: [DataSnapshot] = []
    var iconimages:[String] = []
    var usernames:[String] = []
    var content: [String] = []
    
//投稿
    func post(){
        ref = Database.database().reference()
        ref.child("timeline").childByAutoId().setValue(["UID":"uid","content":"content"])
        
    }
    
//データ読み取り
    func read()  {
        ref.child("test").observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [DataSnapshot] {
                self.snap = snapShots

            }
            self.reloaddata(snap: self.snap)
        })
    }
    
//受信データを配列に格納
    func reloaddata(snap: DataSnapshot) {
        if snap.exists() {
            print(snap)
            for item in snap.children {
                items.append(item  as! DataSnapshot)
            }
        }
    }
//配列を展開し、TableView表示形式に整形。
    func set(){
        for value in items{
             let item = value.value as! Dictionary<String, AnyObject>
            item["content"]
            let postuser = item["UID"] as! String
            finduserdata(uid: postuser)
            
            
            
        }
    
    }
//個人データの取得
    func finduserdata(uid:String)  {
        ref.child("userdata").child(uid).observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [DataSnapshot] {
                self.snap = snapShots

            }

            self.reloaduserddata(snap: self.snap)
        })
    }
    
    //受信データを配列に格納
    func reloaduserddata(snap: DataSnapshot) {
        if snap.exists() {
            print(snap)
            for item in snap.children {
                useritems.append(item  as! DataSnapshot)
            }
        }
    }
    func adduserdata(){
        for value in items{
            let item = value.value as! Dictionary<String, AnyObject>
            usernames.append(item["username"] as! String)
            usernames.append(item["username"] as! String)

        }
        
    }
//以下は表示関係
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

