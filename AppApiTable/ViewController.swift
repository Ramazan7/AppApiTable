//
//  ViewController.swift
//  AppApiTable
//
//  Created by Admin on 16.07.2021.
//
import SnapKit
import Kingfisher
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    var myTableView = UITableView()
    var imageq = UIImageView(image: UIImage(named: ""))
    let indetifire = "MyCell"
    var structJsonn = [structJson]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        createTable()
        downloadJSON{
            self.myTableView.reloadData()
        }
        
       
        
    }
    
    private func initialize(){
        let label = UILabel()
        label.text = "dfkjlsdf"
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(50)
            maker.top.equalToSuperview().inset(150)
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.punkapi.com/v2/beers?page=2&per_page=80")
        
        URLSession.shared.dataTask(with: url!) {(data, response,error) in
            if error == nil {
                do {
                    self.structJsonn = try JSONDecoder().decode([structJson].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("json Error")
                }
            }
        }.resume()
    }
    
    func createTable() {
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: indetifire)
       
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myTableView)
    }
    
   /* func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return structJsonn.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indetifire, for: indexPath)
        
       // cell.textLabel?.text = "section \(indexPath.section) cell = \(indexPath.row)"
        
        cell.textLabel?.text = structJsonn[indexPath.row].name.capitalized
        
       /* let imageName = "https://images.punkapi.com/v2/192.png"
        */
        
        let url = structJsonn[indexPath.row].image_url
        let image = UIImageView()
        image.kf.setImage(with: URL(string: url), placeholder: nil, options: [.transition(.fade(0.7))])
        cell.imageView?.image = image.image
        //work
        //cell.imageView?.image = UIImage(systemName: "pencil")
        
          return cell
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
      
}

/*
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}*/

