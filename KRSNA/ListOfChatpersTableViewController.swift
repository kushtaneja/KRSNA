//
//  ListOfChatpersTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 17/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase

class ListOfChatpersTableViewController: UITableViewController {
        var chapters = [chapter]()
        var ref: FIRDatabaseReference!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
            
            self.updateAndReturnChapters()
            ActivityIndicator.shared.showProgressView(uiView: view)
        }
        
        override func viewDidAppear(_ animated: Bool) {
         
         super.viewDidAppear(true)
            
         self.updateAndReturnChapters()
         ActivityIndicator.shared.showProgressView(uiView: view)
         
         
         }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return chapters.count
        }
        
        
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterListCell", for: indexPath) as! ChapterListTableViewCell
            let chapter: chapter = chapters[indexPath.row]
            
            debugPrint("\(chapter.title) chapterAddedtoTableView")
            
            cell.chapterNameLabel.text = chapter.name
            cell.chapterTitleLabel.text = chapter.title
            cell.numberOfVersesLabel.text = "\((chapter.numberOfVerses)!)" + " " + "verses"
            
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let height = CGFloat(integerLiteral: 106)
            return height
        }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currentChapter: chapter = chapters[indexPath.row]
            
            let gitaNavigationScreen = UIStoryboard.GitaNavigationScreen()
            let chapterVersesScreen = UIStoryboard.ChapterVersesListScreen() as! ChapterVersesTableViewController
            chapterVersesScreen.chapter = currentChapter.name!
            chapterVersesScreen.offset = currentChapter.from!
            chapterVersesScreen.to = currentChapter.to!
            chapterVersesScreen.updateChapterContent(From: (currentChapter.from)!, To: (currentChapter.to)!)
           
            present(gitaNavigationScreen, animated: false) {
                gitaNavigationScreen.pushViewController(chapterVersesScreen, animated: true)
            }
            
            
            
        }
    
        
        // MARK: - Firebase Functions
        
        func updateAndReturnChapters(){
            
            ref = FIRDatabase.database().reference()
            let vrindavan_head = ref.child("new_bgasitis").child("chapters").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
                
                let output = snapshot.value as? NSDictionary
                let name = output?["chapter"] as? String
                let title = output?["title"] as? String
                let from = output?["from"] as? Int
                let to = output?["to"] as? Int
                let numberOfVerses = to! - from!
                
                let currentchapter = chapter(chapterName: name, chapterTitle: title, chapterVerses: numberOfVerses,versesFrom: from, versesTo: to)
                self.chapters.insert(currentchapter, at: self.chapters.count)
                
                debugPrint("\(currentchapter.name) chapter Added")
                
                self.tableView.reloadData()
                
                ActivityIndicator.shared.hideProgressView()
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        
}
