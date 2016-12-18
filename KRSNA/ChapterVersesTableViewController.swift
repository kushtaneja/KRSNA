
//
//  ChapterVersesTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 17/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase


class ChapterVersesTableViewController: UITableViewController {
    
    var to: Int = 0
    var offset: Int = 0
    var ref: FIRDatabaseReference!
    var chapter: String = "Chapter"
    var verses = [verse]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = chapter
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        
        ActivityIndicator.shared.showProgressView(uiView: view)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        updateChapterContent(From: offset, To: to)
        
        ActivityIndicator.shared.showProgressView(uiView: view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 30.0))
        sectionHeaderView.layer.backgroundColor = UIColor.white.cgColor
        let label = UILabel(frame: CGRect(x: 15.0, y: 5.0, width: self.view.frame.width, height: 17.0))
        
        label.textColor = ColorCode().appThemeColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        switch section {
        case 0:
            label.text = "Chapter Overview"
        case 1:
            label.text = "Verses"

        default:
            label.text = ""
            
        }
        
        
        sectionHeaderView.addSubview(label)
        return sectionHeaderView
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Chapter Overview"
        case 1:
            return "Verses"
            
        default:
            return ""
        }
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            if (verses.count > 0)
            {
            return verses.count
            } else {
            return 0
            }
        default:
            return 0
        }
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterVerseTableViewCell", for: indexPath) as! ChapterVerseTableViewCell
        
        
       
        
        switch indexPath.section {
            
        case 0:
            cell.verseHeadingLabel.text = ""
            cell.verseTranlsationLabel.text = ""
            return cell

        case 1:
             let verse = self.verses[indexPath.row]
                cell.verseHeadingLabel.text = "Verse" + " " + "\((verse.number)!)"
                cell.verseTranlsationLabel.text = verse.translation
            return cell
        default:
            cell.verseHeadingLabel.text = ""
            cell.verseTranlsationLabel.text = ""
            return cell
            
        }
     

        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(integerLiteral: 106)
        return height
    }
    // MARK: Firebase Functions
    func updateChapterContent(From: Int,To:Int){
        verses = []
        ref = FIRDatabase.database().reference()
        let query = ref.child("new_bgasitis").child("verselist").queryOrderedByKey().queryStarting(atValue: String(From)).queryEnding(atValue: String(To))
        debugPrint("*From \(From) -- *TO \(To)")
        
        var handle: UInt = query.observe(.childAdded, with:  { (snapshot) in
            
            let output = snapshot.value as? NSDictionary
            let translation = output?["translation"] as? String
            let verseNumber = output?["versenumber"] as? Int
            
            let currentverse = verse(verseNumber: verseNumber! + 1, verseTranslation: translation, verseChapter: self.chapter)
            self.verses.insert(currentverse, at: self.verses.count)
            
            
            debugPrint("Verse \(currentverse.number)  Fetched")
            self.tableView.reloadData()
            ActivityIndicator.shared.hideProgressView()
           
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
       
    }

    
}
