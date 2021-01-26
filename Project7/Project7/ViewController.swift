//
//  ViewController.swift
//  Project7
//
//  Created by mengxiangjian on 2021/1/26.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filterdPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credit", style: .plain, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filterdPetitions = petitions
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredit() {
        let ac = UIAlertController(title: "Credit", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "I know", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Input Your Keyword"
        }
        ac.addAction(UIAlertAction(title: "Filter", style: .default, handler: {[weak self] _ in
            if let text = ac.textFields?[0].text, !text.isEmpty {
                self?.filterdPetitions.removeAll(keepingCapacity: true)
                if let petitions = self?.petitions {
                    for petition in petitions {
                        if petition.title.lowercased().contains(text.lowercased()) ||
                            petition.body.lowercased().contains(text.lowercased()){
                            self?.filterdPetitions.append(petition)
                        }
                    }
                }
                self?.tableView.reloadData()
            } else {
                self?.filterdPetitions = self?.petitions ?? [Petition]()
                self?.tableView.reloadData()
            }
        }))
        present(ac, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterdPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filterdPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let petition = filterdPetitions[indexPath.row]
        vc.detailItem = petition
        navigationController?.pushViewController(vc, animated: true)
    }

}

