//
//  ViewController.swift
//  Challenge2
//
//  Created by mengxiangjian on 2021/1/25.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopItems = [String]()
    var shareToolbarItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAddItemAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(promptDeleteAllAlert))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        shareToolbarItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        shareToolbarItem.isEnabled = false
        toolbarItems = [spacer, shareToolbarItem]
        navigationController?.isToolbarHidden = false
    }

    @objc func promptAddItemAlert() {
        let ac = UIAlertController(title: "Add Shop Item", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            let name = ac.textFields?[0].text
            if let name = name {
                self?.addItem(item: name)
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    @objc func promptDeleteAllAlert() {
        let ac = UIAlertController(title: "Delete All", message: "Do you want to delete all items?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {[weak self] _ in
            self?.deleteAll()
        }))
        present(ac, animated: true, completion: nil)
    }
    
    func addItem(item: String) {
        if !item.isEmpty {
            shopItems.append(item)
            let indexPath = IndexPath(row: shopItems.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            shareToolbarItem.isEnabled = true
        }
    }
    
    func deleteAll() {
        shopItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
        shareToolbarItem.isEnabled = false
    }
    
    @objc func shareShoppingList() {
        let shareText = shopItems.joined(separator: "\n")
        let ac = UIAlertController(title: "Share Shopping List", message: shareText, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shopItems[indexPath.row]
        return cell
    }

}

