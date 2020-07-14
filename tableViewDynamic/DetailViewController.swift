//
//  DetailViewController.swift
//  tableViewDynamic
//
//  Created by Sinergy on 7/14/20.
//  Copyright © 2020 Sinergy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var model:Model?
    var modelDetail:ModelDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = model?.name
        getData {
            self.usernameLabel.text = self.modelDetail?.username
            self.usernameLabel.isHidden = false
        }

        // Do any additional setup after loading the view.
    }
    
    func getData(completed: @escaping () -> ()){
        let url = "https://sinergy-dev.xyz:2096/arrayTableDynamicSpecific"
        
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "id", value: String(self.model!.id))
        ]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    self.modelDetail = try JSONDecoder().decode(ModelDetail.self, from: data!)
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
