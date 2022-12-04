//
//  ViewController.swift
//  track-explorer
//
//  Created by Ярослав Грогуль on 03.12.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data = [Tracks]()
    
    enum Segues {
        static let toDetail = "ShowTrackDetailsSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchingData(URL: "http://5.61.61.212:9900/tracks") { result in
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    func fetchingData(URL url:String, completion: @escaping ([Tracks]) -> Void) {
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil {
                do {
                    let parsingData = try JSONDecoder().decode([Tracks].self, from: data!)
                    completion(parsingData)
                } catch {
                    print("Parsing error")
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toDetail, let destination = segue.destination as? TrackDetailsVC, let trackIndex = tableView.indexPathForSelectedRow?.row {
               destination.track = data[trackIndex]
           }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        var content = cell.defaultContentConfiguration()
        let track = data[indexPath.row]
        content.text = track.name
        content.secondaryText = track.country
        
        cell.contentConfiguration = content
        return cell
    }
}

