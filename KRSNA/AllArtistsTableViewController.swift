//
//  AllArtistsTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 10/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit
import SDWebImage

class AllArtistsTableViewController: UITableViewController {
    
    var artists = [SongClassifier]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return artists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! MusicArtistTableViewCell
        
        let artist = artists[indexPath.row]
        
        cell.nameLabel.text = artist.name
        
        cell.displayImageView.sd_setImage(with: URL(string:(artist.imageUrl)!)!,placeholderImage: #imageLiteral(resourceName: "Rectangle"))
        cell.clipsToBounds = true
        
        cell.displayImageView.layer.cornerRadius = cell.displayImageView.frame.width*0.5

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
