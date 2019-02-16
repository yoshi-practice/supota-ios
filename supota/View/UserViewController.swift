//
//  UserViewController.swift
//  supota
//
//  Created by 築山朋紀 on 2019/02/16.
//  Copyright © 2019 柳川優稀. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.allowsSelection = false
            tableView.backgroundColor = .black
            tableView.register(HomeTableViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.setImage(with: "https://pbs.twimg.com/profile_images/1034494131379220480/ooUVH5FH_400x400.jpg")
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableViewHeight.constant = tableView.contentSize.height - tableView.frame.height
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeusReusableCell(of: HomeTableViewCell.self, for: indexPath)
        cell.update()
        return cell
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
