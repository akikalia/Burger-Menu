//
//  BurgerTableHeader.swift
//  BurgerMenu
//
//  Created by Alexsandre kikalia on 12/21/20.
//

import UIKit

protocol BurgerTableHeaderDelegate: AnyObject {
    func burgerTableHeaderDidTapClose(_ sender: BurgerTableHeader)
    
    func burgerTableHeaderDidTapExpand(_ sender: BurgerTableHeader)
    
    func burgerTableHeaderSetupActiveColor(_ sender: BurgerTableHeader) -> UIColor
    
}

class BurgerTableHeader: UITableViewHeaderFooterView {

    @IBOutlet var toggle: MenuToggleView!
    var activeColor:UIColor = .red
    
    weak var delegate: BurgerTableHeaderDelegate? {
        didSet {
            activeColor  = delegate?.burgerTableHeaderSetupActiveColor(self) ?? activeColor
            toggle.delegate = self
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

}

extension BurgerTableHeader:MenuToggleViewDelegate{
    
    func menuToggleViewDidTapClose(_ sender: MenuToggleView) {
        delegate?.burgerTableHeaderDidTapClose(self)
    }
    
    func menuToggleViewDidTapExpand(_ sender: MenuToggleView) {
        delegate?.burgerTableHeaderDidTapExpand(self)
    }
    
    func menuToggleViewSetupActiveColor(_ sender: MenuToggleView) -> UIColor {
        return activeColor
    }
    

}
