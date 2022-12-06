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
    @IBOutlet var TrackWikiInfo: UILabel!
    
    var track = Tracks()
    var imageUrl = String()
    var trackDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage(wiki_url: track.url!) { result in
            DispatchQueue.main.async {
                self.HeaderImage.image = result
                self.HeaderImage.contentMode = .scaleAspectFit
            }
        }
        fetchIntro(wiki_url: track.url!) { result in
            DispatchQueue.main.async {
                self.TrackWikiInfo.text = result
            }
        }
        
        TrackNameLabel.text = track.name
        TrackInfo.text = """
Located in \(track.location ?? "unknown city"), \(track.country ?? "unknown country").
"""
    }
    
    
    
    func fetchImage(wiki_url: String, completion: @escaping (UIImage) -> Void) {
        let page_name = String(wiki_url.suffix(from: wiki_url.lastIndex(of: "/")!).dropFirst(1))
        
        let image_url = "https://en.wikipedia.org/w/api.php?action=query&titles="+page_name+"&prop=pageimages&format=json&pithumbsize=500&redirects"
        
        let url = URL(string: image_url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil {
                var parsingData = String(decoding: data!, as: UTF8.self)
                parsingData = String(String(parsingData.split(separator: "source")[1]).split(separator: "width")[0])
                parsingData = String(parsingData.dropLast(3).dropFirst(3))
//                completion(parsingData)
                self.loadImageFrom(url: parsingData, completion: {result in
                    completion(result)
                })
            }
        }
        dataTask.resume()
    }
    
    func fetchIntro(wiki_url: String, completion: @escaping (String) -> Void) {
        let page_name = String(wiki_url.suffix(from: wiki_url.lastIndex(of: "/")!).dropFirst(1))
        
        let into_url = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles="+page_name
        
        let url = URL(string: into_url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil {
                var parsingData = String(decoding: data!, as: UTF8.self)
                parsingData = String(String(parsingData.split(separator: "extract")[1]).split(separator: "}")[0])
                parsingData = String(parsingData.dropLast(1).dropFirst(3))
                completion(parsingData)
            }
        }
        dataTask.resume()
    }
    
    func loadImageFrom(url: String, completion: @escaping (UIImage) -> Void)  {
        if let url = URL(string: url) {
            let session = URLSession.shared.dataTask(with: url) { data, response, error in
                if data != nil && error == nil {
//                    DispatchQueue.main.async {
//                        self.HeaderImage.image = UIImage(data: data!)
//                        self.HeaderImage.contentMode = .scaleAspectFill
//                    }
                    completion(UIImage(data: data!)!)
                }
            }
            session.resume()
        }
        
    }
}

    
