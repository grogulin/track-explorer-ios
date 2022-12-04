//
//  TrackDetailsVC.swift
//  track-explorer
//
//  Created by Ярослав Грогуль on 04.12.2022.
//

import UIKit

class TrackDetailsVC: UIViewController {

    @IBOutlet var TrackNameLabel: UILabel!
    @IBOutlet var TrackInfo: UILabel!
    @IBOutlet var HeaderImage: UIImageView!
    
    var track = Tracks()
    var imageUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage(wiki_url: track.url!) { result in
//            self.imageUrl = result
            print(type(of: result))
//            print(type(of: test))
            print(result)
            self.view.bringSubviewToFront(self.TrackNameLabel)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
        
        
        TrackNameLabel.text = track.name
        
        TrackInfo.text = """
Located in \(track.location ?? "unknown city"), \(track.country ?? "unknown country").

"""
    }
    
    func fetchImage(wiki_url: String, completion: @escaping (UIImage) -> Void) {
        var page_name = String(wiki_url.suffix(from: wiki_url.lastIndex(of: "/")!).dropFirst(1))
        
        var image_url = "https://en.wikipedia.org/w/api.php?action=query&titles="+page_name+"&prop=pageimages&format=json&pithumbsize=500&redirects"
        
        let url = URL(string: image_url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil {
//                let parsingData = try String(decoding: data!, as: UTF8.self)
//                completion(parsingData)
                do {
                    var parsingData = try String(decoding: data!, as: UTF8.self)
                    parsingData = String(String(parsingData.split(separator: "source")[1]).split(separator: "width")[0])
                    parsingData = String(parsingData.dropLast(3).dropFirst(3))
                    
                    self.HeaderImage.loadFrom(URLAddress: parsingData)
//                    completion(parsingData)
                } catch {
                    print("Parsing error")
                    print(error)
                }
            }
        }
        dataTask.resume()
        
//        print(image_url)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return self.image = UIImage(named: "defaultTrack")
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    self?.contentMode = .scaleAspectFill
                    
//
//                        if loadedImage.size.width > loadedImage.size.height {
//                            // fit
//                            self?.contentMode = .scaleAspectFill
//                        } else {
//                            // fill
//                            self?.contentMode = .scaleAspectFill
//                        }
                }
            }
        }
    }
}
