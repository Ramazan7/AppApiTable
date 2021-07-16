//
//  ViewController.swift
//  AppApiTable
//
//  Created by Admin on 16.07.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    var myTableView = UITableView()
    let indetifire = "MyCell"
    var structJsonn = [structJson]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        downloadJSON{
            self.myTableView.reloadData()
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
        
          return cell
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
      
}

