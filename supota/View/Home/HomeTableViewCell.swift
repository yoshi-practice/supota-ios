//
//  HomeTableViewCell.swift
//  supota
//
//  Created by 築山朋紀 on 2019/02/16.
//  Copyright © 2019 柳川優稀. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    private let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .black
        self.contentView.backgroundColor = .black
        self.addSubview(userImageView)
        self.addSubview(nameLabel)
        self.addSubview(idLabel)
        self.addSubview(messageLabel)
        
        setLayout()
    }
    
    func update() {
        userImageView.setImage(with: "https://pbs.twimg.com/profile_images/1095642952326467584/A21SUD3G_400x400.jpg")
        nameLabel.text = "東 慧紀"
        idLabel.text = "@Satoqqqu_"
        messageLabel.text = "昨日の試合めっちゃやばかった！！！\n@username もめっちゃいい動きしてたしやっぱ最高だな！！"
    }
    
    private func setLayout() {
        userImageView.snp.makeConstraints { make in
            make.top.left.equalTo(16)
            make.size.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(8)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel)
            make.right.equalTo(idLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
