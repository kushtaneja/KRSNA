
//
//  SongsTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 11/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase

class SongsTableViewController: UITableViewController {
    
    var songs = [Song]()
    var fromOuter : Bool = true
    var type:MusicType = MusicType.category
    var typeName = ""
    var typeTitle = ""
    var ref = FIRDatabaseReference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = typeTitle
        ActivityIndicator.shared.showProgressView(uiView: self.view)
        insert()
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if songs.count == 0 {
        return 1
            
        }else{
            return songs.count + 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShuffleCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
            
            let currentSong = songs[indexPath.row - 1]
            
            cell.songImageView.sd_setImage(with: URL(string:currentSong.imageLink!)!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
            
            cell.nameLabel.text = currentSong.title
            cell.artistNameLabel.text = currentSong.artist

            return cell
            
        }
        

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 44.0
        default:
            return 60.0
        }
    }
    
 
    
    func insert(){
        
        ref  = FIRDatabase.database().reference()
        
        ref.child("new_music").child("music").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
            self.ref.child("new_music").child("music").child(snapshot.key).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                
                let output = snap.value as? NSDictionary

                if output != nil {
                    
                    var title = output?[self.typeName] as? String
                    var comparison = ""
                    switch self.typeTitle{
                        case "Gita":
                        comparison = "bhagavad gita"
                        case "Krishna":
                        comparison = "krishna songs"
                    default:
                        comparison = self.typeTitle
                    }
                    
                  
                    if title != nil {
                        
                        
                        if (title?.lowercased() == comparison.lowercased()){
                            print("\(self.typeName)  **T** \(title) *****  \((self.typeTitle).lowercased())")
                            let album = output?["album"] as? String
                            let artist = output?["artist"] as? String
                            let category = output?["category"] as? String
                            
                            let image = output?["image"] as? String
                            let source = output?["source"] as? String
                            let title = output?["title"] as? String
                            let duration = output?["duration"] as? Int
                            let likes = output?["likes"] as? Int
                            let shares = output?["shares"] as? Int
                            let views = output?["views"] as? Int
                            
                            let song = Song(songAlbum: album, songArtist: artist, songDuration: duration, songImageLink: image, songLikes: likes, songShares: shares, songSource: source, songTitle: title, songViews: views, songTypes: [self.type])
                            self.songs.append(song)
                            self.tableView.reloadData()
                            ActivityIndicator.shared.hideProgressView()
                    }
                    

                 }
                }
            },withCancel: { (error) in
                print(error.localizedDescription)
            })
            
            ActivityIndicator.shared.hideProgressView()
        } ,withCancel: { (error) in
            print(error.localizedDescription)
        })

    ActivityIndicator.shared.hideProgressView()
        
    }
    

    @IBAction func dismiss(_ sender: Any) {
        
        if !fromOuter {
            UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
        }else{
          self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
    }

    }
