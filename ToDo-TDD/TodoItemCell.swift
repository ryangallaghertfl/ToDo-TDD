//
//  TodoItemCell.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 21/11/2023.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    
    let titleLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel = UILabel()
        
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
