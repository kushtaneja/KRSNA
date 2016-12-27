
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
    var changedChapter: String = "Chapter"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        changedChapter = chapter
        self.navigationItem.title = chapter
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        ActivityIndicator.shared.showProgressView(uiView: view)
        self.tableView.reloadData()
       // updateChapterContent(From: offset, To: to)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        
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
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(20)
        default:
            return CGFloat(0)
        }
        
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
        if (verses.count > 0) {
            tableView.sectionHeaderHeight = CGFloat(integerLiteral: 30)
            tableView.sectionFooterHeight = CGFloat(integerLiteral: 10)
            
            switch section {
            case 0:
                return 1
            case 1:
                return verses.count - 1
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterVerseTableViewCell", for: indexPath) as! ChapterVerseTableViewCell
        
        switch indexPath.section {
            
        case 0:
            if ((indexPath.row) == 0)
            {
            let verse = self.verses[indexPath.row]
            cell.isUserInteractionEnabled = false
            cell.verseHeadingLabel.text = verse.verse
                
            cell.verseTranlsationLabel.text = verse.translation
            return cell
            }
            else {
                cell.verseHeadingLabel.text = ""
                cell.verseTranlsationLabel.text = ""
                return cell
            }
        case 1:
             let verse = self.verses[indexPath.row + 1]
                cell.verseNumber = verse.key
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
            
            let key = Int(snapshot.key)
            let output = snapshot.value as? NSDictionary
            
            let translation = output?["translation"] as? String
            let verseNumber = output?["versenumber"] as? Int
            let verseContent = output?["verse"] as? String

            let currentverse = verse(verseNumber: verseNumber!, verseTranslation: translation, verseChapter: self.chapter,verseContent:verseContent,atKey: key)
            
            self.verses.insert(currentverse, at: self.verses.count)
            
            self.tableView.reloadData()
            debugPrint("Verse \(currentverse.number!)  Fetched a key \(key)")
            
            ActivityIndicator.shared.hideProgressView()
           
        }) { (error) in
            print(error.localizedDescription)
        }
       
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 1){
            
            let cell = tableView.cellForRow(at: indexPath) as! ChapterVerseTableViewCell
            
            let verseDisplayNavigationScreen = UIStoryboard.verseDisplayNavigationScreen()
            let verseDisplayScreen = verseDisplayNavigationScreen.topViewController as! ChapterVersesDisplayCollectionViewController
            verseDisplayScreen.chapter = self.chapter
            
            verseDisplayScreen.selectedVerse = self.offset+cell.verseNumber!
            verseDisplayScreen.selectedKey = cell.verseNumber!
            verseDisplayScreen.number = verses.count - 1
            verseDisplayScreen.updateChapterContent(offset: cell.verseNumber!,index: 0,prefetch: false)
            UIApplication.topViewController()?.present(verseDisplayNavigationScreen, animated: true, completion: nil)
        
        }
        
        
    }
    
    
    @IBAction func didBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }

    
}
