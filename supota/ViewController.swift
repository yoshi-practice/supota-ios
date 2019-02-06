
import FirebaseDatabase
import Firebase
import UIKit
import FirebaseStorage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var TextFeild:UITextField!
    @IBOutlet var TextView:UITextView!
    var Table:UITableView!
    var snap: DataSnapshot!
    var ref: DatabaseReference!
    var items: [DataSnapshot] = []
    var useritems: [DataSnapshot] = []
    var inages: [String] = []
    var uid:[String] = []
    var usernames:[String] = []
    var content: [String] = []
    
    
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
    
    func getprofileimage(uid:String) -> UIImage {
        var profileImage:UIImage!
        let imagePath = Storage.storage().reference().child("profile/\(uid).jpg")
        
        // 画像のDLサイズはお好みで調整してください
        imagePath.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
            } else {
                profileImage = UIImage(data: data!)
                
            }
        }
        return profileImage
    }
    func getcontentimage(image:String) -> UIImage {
        var profileImage:UIImage!
        let imagePath = Storage.storage().reference().child("content/\(image).jpg")
        
        // 画像のDLサイズはお好みで調整してください
        imagePath.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
            } else {
                profileImage = UIImage(data: data!)
                
            }
        }
        return profileImage
    }

    
    func adduserdata(){
        for value in items{
            let item = value.value as! Dictionary<String, AnyObject>
            usernames.append(item["username"] as! String)
            uid.append(item["uid"] as! String)
            inages.append(item["images"] as! String)
            
        }
        
    }
//以下は表示関係
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 生成するCellの数
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  Cellの指定
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell") as! TimelineTableTableViewCell
        //  Cellに入れる要素の指定
        cell.username.text = usernames[indexPath.row]
        cell.ImageView.image = getprofileimage(uid: usernames[indexPath.row])
        //      画像がないときにCellの高さを縮小して ImageViewを消す
        
        if inages[indexPath.row] == "none"{
            Table.estimatedRowHeight = Table.estimatedRowHeight - 30
            cell.ContentImageView.isHidden = true
        }else{
        cell.ContentImageView.image = getcontentimage(image: inages[indexPath.row])

        }
        
        return cell
    }


    
}

