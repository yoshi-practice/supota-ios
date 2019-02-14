
import FirebaseDatabase
import Firebase
import UIKit
import FirebaseStorage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var TextFeild:UITextField!
    @IBOutlet var TextView:UITextView!
    @IBOutlet var Table:UITableView!
    var snap: DataSnapshot!
    var usersnap:DataSnapshot!
    let ref = Database.database().reference()
    var items: [DataSnapshot] = []
    var useritems: [DataSnapshot] = []
    var inages: [String] = []
    var likes: [String] = []
    var uid:[String] = []
    var usernames:[String] = []
    var content: [String] = []
    var postid: [String] = []
    
    
//データ読み取り
    func read()  {
        ref.child("timeline").observe(.value, with: {(snapShots) in
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
        set()
    }
    
//配列を展開し、TableView表示形式に整形。
    func set(){
        for value in items{
            let item = value.value as! Dictionary<String, AnyObject>
//            usernames.append(item["username"] as! String)
            uid.append(item["UID"] as! String)
            inages.append(item["image"] as! String)
            likes.append(item["likes"] as! String)
            postid.append(item["timestamp"] as! String)
            let postuser = item["UID"] as! String
            finduserdata(uid: postuser)
        }
        Table.reloadData()

    }
    
//個人データの取得
    func finduserdata(uid:String)  {
        ref.child("userdata").child(uid).child("username").observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [DataSnapshot] {
                self.usersnap = snapShots
                self.usernames.append((snapShots.value! as AnyObject).description)
                print(self.usernames)
            }
        })
        Table.reloadData()
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
//以下は表示関係
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.delegate = self
        Table.dataSource = self
        read()
   
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 生成するCellの数
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  Cellの指定
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell") as! TimelineTableTableViewCell
        //  Cellに入れる要素の指定
        cell.username.text = usernames[indexPath.row]
        cell.ImageView.image = getprofileimage(uid: usernames[indexPath.row])
        cell.likes.setTitle(likes[indexPath.row], for: .normal)
        cell.likes.tag = indexPath.row
        cell.likes.addTarget(self, action: "pushButton:", for: .touchUpInside)
        
        return cell
    }
    @objc private func pushButton(_ sender:UIButton)
    {
        let row = sender.tag
        timeline().like(postid: postid[row], like: String(Int(likes[row])!+1))
    }


    
}

