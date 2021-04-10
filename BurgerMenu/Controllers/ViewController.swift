//
//  ViewController.swift
//  BurgerMenu
//
//  Created by Alexsandre kikalia on 12/19/20.
//

import UIKit

class ViewController: BurgerTableController {

    @IBOutlet var viewGreen: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.bringSubviewToFront(tableView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

    }

}

