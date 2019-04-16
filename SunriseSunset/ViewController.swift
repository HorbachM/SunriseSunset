//
//  ViewController.swift
//  SunriseSunset
//
//  Created by Horbach on 20.03.19.
//  Copyright © 2019 Horbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var SunriseLabel: UILabel!
    
    @IBOutlet weak var SunsetLabel: UILabel!
    
    struct Result : Codable {
        let results : Sun
    }
    
    struct Sun: Codable {
        let sunrise: String
        let sunset: String
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 1
        let urlString = "https://api.sunrise-sunset.org/json?lat=49.841952&lng=24.0315921&date=today"
        guard let url = URL(string: urlString) else { return }
        
        // 2
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            do {
                // 3
                //Decode data
                let JSONData = try JSONDecoder().decode(Result.self, from: data)
                
                // 4
                //Get back to the main queue
                DispatchQueue.main.async {
                  self.SunriseLabel.text = JSONData.results.sunrise
                  self.SunsetLabel.text = JSONData.results.sunset
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            // 5
            }.resume()
        
    }


}

