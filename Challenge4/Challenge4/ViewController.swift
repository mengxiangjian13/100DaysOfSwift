//
//  ViewController.swift
//  Challenge4
//
//  Created by mengxiangjian on 2021/2/5.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos = [Photo]()
    
    var editButton: UIButton!
    var editingMode = false {
        didSet {
            editButton.setTitle(editingMode ? "Done" : "Edit", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let data = UserDefaults.standard.object(forKey: "photos") as? Data {
            if let savedPhotos = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Photo]{
                photos = savedPhotos
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickImage))
        editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: editButton)
    }
    
    @objc func pickImage() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc func edit() {
        editingMode.toggle()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let uuid = UUID().uuidString
            if let data = image.jpegData(compressionQuality: 0.8) {
                try? data.write(to: getDocumentDirectory().appendingPathComponent(uuid))
            }
            
            let photo = Photo(caption: "unknown", image: uuid)
            photos.append(photo)
            
            tableView.reloadData()
            
            save()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PhotoCell else {
            fatalError()
        }
        
        let photo = photos[indexPath.row]
        cell.captionLabel.text = photo.caption
        cell.thumbnail.image = UIImage(contentsOfFile: getDocumentDirectory().appendingPathComponent(photo.image).path)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if editingMode {
            let photo = photos[indexPath.row]
            let ac = UIAlertController(title: "Rename caption", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] _ in
                if let text = ac.textFields?[0].text, !text.isEmpty {
                    photo.caption = text
                    self?.tableView.reloadData()
                    self?.save()
                }
            }))
            present(ac, animated: true, completion: nil)
        } else {
            if let vc = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController {
                let photo = photos[indexPath.row]
                vc.image = UIImage(contentsOfFile: getDocumentDirectory().appendingPathComponent(photo.image).path)
                vc.title = photo.caption
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func getDocumentDirectory() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return url[0]
    }
    
    func save() {
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: photos, requiringSecureCoding: false) {
            UserDefaults.standard.set(data, forKey: "photos")
            UserDefaults.standard.synchronize()
        }
    }

}

