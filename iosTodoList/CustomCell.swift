//
//  CustomeCell.swift
//  iosTodoList
//
//  Created by 桑古　昌輝 on 2016/03/30.
//  Copyright © 2016年 桑古　昌輝. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var deadline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(task :Task) {
        self.taskName?.text = task.taskName as String
        self.deadline?.text = task.deadline as String
    }


}
