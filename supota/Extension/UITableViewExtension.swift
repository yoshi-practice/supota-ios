//
//  UITableViewExtension.swift
//  supota
//
//  Created by 築山朋紀 on 2019/02/16.
//  Copyright © 2019 柳川優稀. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewFocusUpdateContext: Reusable {}

extension UITableView {
    func register<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeusReusableCell<Cell: UITableViewCell>(of cellClass: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? Cell else {
            assertionFailure("\(Cell.self)は登録されていません。")
            register(cellClass.self)
            return cellClass.init(style: .default, reuseIdentifier: cellClass.reuseIdentifier)
        }
        return cell
    }
}

