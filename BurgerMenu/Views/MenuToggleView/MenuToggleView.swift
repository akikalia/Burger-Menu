//
//  MenuToggleView.swift
//  BurgerMenu
//
//  Created by Alexsandre kikalia on 12/19/20.
//


import UIKit



protocol MenuToggleViewDelegate: AnyObject {
    func menuToggleViewDidTapClose(_ sender: MenuToggleView)
    func menuToggleViewDidTapExpand(_ sender: MenuToggleView)
    func menuToggleViewSetupActiveColor(_ sender: MenuToggleView) -> UIColor
}

class MenuToggleView : BaseReusableView{
    weak var delegate: MenuToggleViewDelegate? {
        didSet {
            activeColor = delegate?.menuToggleViewSetupActiveColor(self) ?? activeColor
            
            if !isOpen{
                setExpandViewColor(color: activeColor)
            }
        }
    }
    
    @IBOutlet weak var closeView: UIImageView!
    @IBOutlet weak var expandView: UIView!
    
    var activeColor =  UIColor.red
    var inactiveColor = UIColor.systemGray3
    
    var isOpen = false
    
    override func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let touchDown = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTouchDown(_:)))
        touchDown.minimumPressDuration = 0.1
        touchDown.cancelsTouchesInView = false
        tap.cancelsTouchesInView = false
        
        contentView.addGestureRecognizer(tap)
        contentView.addGestureRecognizer(touchDown)
        
        closeView.backgroundColor = .clear
        expandView.backgroundColor = .clear
        setCloseViewColor(color: .clear)
        setExpandViewColor(color: activeColor)
    }
    
    func setCloseViewColor(color: UIColor){
        closeView.tintColor = color
    }
    
    func setExpandViewColor(color: UIColor){
        
        for bar in expandView.subviews {
            bar.backgroundColor = color
        }
    }
    
    func transitionToClosed(){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.setExpandViewColor(color: self.activeColor)
                self.setCloseViewColor(color: .clear)
                self.contentView.transform = .identity
            }, completion: nil)
        }
    }
    
    func transitionToExpanded(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.setExpandViewColor(color: .clear)
                self.setCloseViewColor(color: self.inactiveColor)
                self.contentView.transform = self.contentView.transform.rotated(by: -1 * CGFloat.pi/2) //CGAffineTransform.init(rotationAngle: CGFloat.init(Double.pi / 2))
            }, completion: nil)
        }
    }
    
    func tap(){
        if isOpen {
            isOpen = false
            transitionToClosed()
            delegate?.menuToggleViewDidTapClose(self)
        }else{
            isOpen = true
            transitionToExpanded()
            delegate?.menuToggleViewDidTapExpand(self)
        }
    }
    
    @objc
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if sender?.state == .ended{
            tap()
        }
    }
    
    @objc
    func handleTouchDown(_ sender: UILongPressGestureRecognizer? = nil) {
        if isOpen {
            if sender?.state == .began{
                self.setCloseViewColor(color: self.activeColor)
            }else if sender?.state == .ended{
                self.setCloseViewColor(color: self.inactiveColor)
                tap()
            }
        }else if sender?.state == .ended{
            tap()
        }
    }
}

