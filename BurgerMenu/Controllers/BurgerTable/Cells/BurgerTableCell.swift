//
//  BurgerTableCell.swift
//  BurgerMenu
//
//  Created by Alexsandre kikalia on 12/20/20.
//

import UIKit

class BurgerTableCell: UITableViewCell {
    @IBOutlet weak var labelView: UILabel!
    var activeColor = UIColor.red
    var inactiveColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelView.textColor = inactiveColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setTitle(title: String?){
        labelView.text = title
    }
}

