//
//  ViewController.swift
//  tableViewDynamic
//
//  Created by Sinergy on 7/14/20.
//  Copyright © 2020 Sinergy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var model = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData{
            print("Successfull")
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.default, reuseIdentifier: nil)
        cell.textLabel?.text = model[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.model = model[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func getData(completed: @escaping () -> ()){
        let url = URL(string: "https://sinergy-dev.xyz:2096/arrayTableDynamic")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.model = try JSONDecoder().decode([Model].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }


}

