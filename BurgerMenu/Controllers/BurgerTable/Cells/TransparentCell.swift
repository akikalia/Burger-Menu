//
//  TransparentCell.swift
//  BurgerMenu
//
//  Created by Alexsandre kikalia on 12/21/20.
//

import UIKit

class TransparentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        
        // Configure the view for the selected state
    }

}
