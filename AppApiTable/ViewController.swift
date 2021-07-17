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
    
    let tableViewController = UITableViewController(style: .plain)
    var refresh = UIRefreshControl()
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
        
        self.refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        self.myTableView.addSubview(refresh)
        
    }
    
    @objc func refreshTable() {
        self.myTableView.reloadData()
        refresh.endRefreshing()
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
        image.kf.indicatorType = .activity
        image.kf.setImage(with: URL(string: url), placeholder: nil, options: [.transition(.fade(0.7))],progressBlock: nil)
        cell.imageView?.image = image.image
        //work
        //cell.imageView?.image = UIImage(systemName: "pencil")
        
          return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let dataview = dataViewController()
        
        dataview.structData = structJsonn[(self.myTableView.indexPathForSelectedRow?.row)!]
        self.present(dataview, animated: true)
        
        
    }
   
   
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("test prepare")
        if let destination = segue.destination as? dataViewController {
            destination.structData = structJsonn[(self.myTableView.indexPathForSelectedRow?.row)!]
        }
    }*/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
      
}

