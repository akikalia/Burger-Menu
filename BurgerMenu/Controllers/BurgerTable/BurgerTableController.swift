//
//  BurgerTableController.swift
//  BurgerMenu
//
//  Created by Alexsandre kikalia on 12/20/20.
//

import UIKit

class BurgerTableController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var labels = ["about us", "products", "media", "contact us"]
    var open = false
    var activeColor : UIColor = .orange
    var inactiveColor : UIColor = .gray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BurgerTableCell", bundle: nil), forCellReuseIdentifier: "BurgerTableCell")
        tableView.register(UINib(nibName: "BurgerTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "BurgerTableHeader")
        tableView.register(UINib(nibName: "TransparentCell", bundle: nil), forCellReuseIdentifier: "TransparentCell")
        
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        
    }

}

extension BurgerTableController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if open{
                return labels.count
            
            }
        }
        return 0
   }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()

        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: -22)// * CGFloat.init(indexPath.row))
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.2,//Double.init(indexPath.row),
            delay: Double.init(indexPath.row) * 0.1,
            animations:{
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BurgerTableHeader")
            if let hdr = header as? BurgerTableHeader {
                hdr.delegate = self
            }
            return header
        }
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerTableCell", for: indexPath)
            if let btCell = cell as? BurgerTableCell {
                btCell.setTitle(title:labels[indexPath.row])
            }
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "TransparentCell", for: indexPath)
            
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 63
        }else{
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 44
        }else{
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let btCell = cell as? BurgerTableCell {
            btCell.labelView.textColor = activeColor
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let btCell = cell as? BurgerTableCell {
            btCell.labelView.textColor = btCell.inactiveColor
        }
    }
}
extension BurgerTableController: BurgerTableHeaderDelegate{
    func burgerTableHeaderDidTapClose(_ sender: BurgerTableHeader) {
        open = false
        UIView.animate(
            withDuration: 0.2,
            animations:{
                self.tableView.backgroundColor = .clear
            }
        )
        self.tableView.reloadData()
    }
    
    func burgerTableHeaderDidTapExpand(_ sender: BurgerTableHeader) {
        open = true
        tableView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        tableView.reloadData()
    }
    
    func burgerTableHeaderSetupActiveColor(_ sender: BurgerTableHeader) -> UIColor {
        return activeColor
    }
    
    func burgerTableHeaderSetupInactiveColor(_ sender: BurgerTableHeader) -> UIColor {
        return inactiveColor
    }
    
    
}
