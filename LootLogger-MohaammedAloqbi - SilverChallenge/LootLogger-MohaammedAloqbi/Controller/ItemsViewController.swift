//
//  ItemsViewController.swift
//  LootLogger-MohaammedAloqbi
//
//  Created by Mohammed on 13/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    
  }
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
      updateUI()
    }
  }
  @IBAction func toggleEdittingMode(_ sender: UIButton) {
    if isEditing {
      
      sender.setTitle("Edit", for: .normal)
      
      setEditing(false, animated: true)
    } else {
      
      sender.setTitle("Done", for: .normal)
      
      setEditing(true, animated: true)
    }
  }
  
  
  func updateUI() {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
    tableView.contentInset = insets
    tableView.scrollIndicatorInsets = insets
    
    let footerView = UIView()
    let footColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    footerView.backgroundColor = footColor
    footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
    let footLabel = UILabel()
    footLabel.text = " No more items!"
    footerView.addSubview(footLabel)
    footLabel.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
    footLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
    footLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor).isActive = true
    footLabel.rightAnchor.constraint(equalTo: footerView.rightAnchor).isActive = true
    footLabel.translatesAutoresizingMaskIntoConstraints = false
    footLabel.adjustsFontForContentSizeCategory = true
    
    if itemStore.allItems.count == 0 {
      tableView.tableFooterView = footerView
    } else {
      tableView.tableFooterView = nil
    }
  }
  
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    let item = itemStore.allItems[indexPath.row]
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell
  }
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      
      itemStore.removeItem(item)
     
      tableView.deleteRows(at: [indexPath], with: .automatic)
      updateUI()
    }
    
  }
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
}