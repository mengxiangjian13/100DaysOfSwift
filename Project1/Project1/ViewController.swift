//
//  ViewController.swift
//  Project1
//
//  Created by mengxiangjian on 2021/1/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var pictureShowCountDict = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        if let dict = UserDefaults.standard.dictionary(forKey: "counts") as? [String: Int] {
            pictureShowCountDict = dict
        }
        DispatchQueue.global().async {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("nssl") {
                    self.pictures.append(item)
                }
            }
            self.pictures.sort()
            print(self.pictures)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let name = pictures[indexPath.row]
        cell.textLabel?.text = name
        let count = pictureShowCountDict[name] ?? 0
        cell.detailTextLabel?.text = "\(count) views"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let name = pictures[indexPath.row]
            vc.selectedImage = name
            vc.selectedImageIndex = "\(indexPath.row + 1)/\(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
            
            if var count = pictureShowCountDict[name] {
                count += 1
                pictureShowCountDict[name] = count
            } else {
                pictureShowCountDict[name] = 1
            }
            UserDefaults.standard.set(pictureShowCountDict, forKey: "counts")
            UserDefaults.standard.synchronize()
        }
    }
}

