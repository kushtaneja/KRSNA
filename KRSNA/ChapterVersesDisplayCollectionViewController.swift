//
//  ChapterVersesDisplayCollectionViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 24/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ChapterVersesDisplayCollectionViewCell"

class ChapterVersesDisplayCollectionViewController: UICollectionViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSourcePrefetching{
    var verses = [verse]()
    
    var selectedVerse: Int = 0
    var chapter: String = "Chapter"
    var currentVerse: verse?
    var nextVerse: verse?
    var initalCount: Int = 0
    var visibleVerseCell: ChapterVersesDisplayCollectionViewCell?
    var selectedKey: Int = 0
    var number: Int = 0
    var added: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            self.collectionView?.prefetchDataSource = self
        } else {
            // Fallback on earlier versions
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if (verses.count != 0){
            return number
        } else{
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChapterVersesDisplayCollectionViewCell
        cell.currentVerse = verses[indexPath.row]
        cell.nextVerse = (indexPath.row != self.number-1) || (indexPath.row != self.number-2) ? verses[indexPath.row+1] : nextVerse
        cell.tableView.delegate = self
        cell.tableView.dataSource = self
        cell.tableView.tableFooterView = UIView(frame: CGRect.zero)
        cell.tableView.estimatedRowHeight = 106.0
        cell.verseOverviewTextView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
        
        for indexPath in indexPaths {
            debugPrint("Updating Prefetch for \(indexPath.row) \n")
            self.updateChapterContent(offset: selectedKey,index: indexPath.row,prefetch:true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]){
        
        for indexPath in indexPaths {
            debugPrint("Cancelling Prefetch for \(indexPath.row) \n")
            verses.remove(at: indexPath.row)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        let cell = cell as! ChapterVersesDisplayCollectionViewCell
        
        currentVerse = cell.currentVerse
        nextVerse = cell.nextVerse
        self.navigationItem.title = self.chapter + " - " + "Verse" + " " + "\((cell.currentVerse?.number)!)"
        cell.tableView.reloadData()
        cell.verseOverviewTextView.text = cell.currentVerse?.verse
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
    }
    
    
    
    //MARK: FIREBASE
    
    func updateChapterContent(offset:Int,index:Int? = 0,prefetch:Bool){
        
        self.initalCount = self.verses.count
        debugPrint("AAAAAA**** \(initalCount)")
        ActivityIndicator.shared.showProgressView(uiView: self.view)
        let ref: FIRDatabaseReference! = FIRDatabase.database().reference()
        
//        ref.keepSynced(true)
        var i: Int = index!
        var query: FIRDatabaseQuery!
        
        if (index! == self.number-1){
             query = ref.child("new_bgasitis").child("versedetails").queryEqual(toValue: String(offset + index!))
        } else{
             query = ref.child("new_bgasitis").child("versedetails").queryOrderedByKey().queryStarting(atValue: String(offset + index!)).queryEnding(atValue: String(offset + index! + 1))
        }
        
        
        var handle: UInt = query.observe(.childAdded, with:  { (snapshot) in
            
            let output = snapshot.value as? NSDictionary
            let audioUrl = output?["audioUrl"] as? String
            let purport = output?["purport"] as? String
            let imageUrl = output?["url"] as? String
            let translation = output?["translation"] as? String
            let verseNumber = output?["versenumber"] as? Int
            let verseContent = output?["verse"] as? String
            let wordForWord = output?["wordforword"] as? String
            
            let currentverse = verse(verseNumber: verseNumber, verseAudioUrl: audioUrl, verseContent: verseContent, verseWordForWord: wordForWord, verseTranslation: translation, versePurport: purport, verseChapter: self.chapter, verseImageUrl: imageUrl)
            
            debugPrint("VERSEEE ---- \n audioUrl\(audioUrl)\n purport\(purport)\n imageUrl\(imageUrl)\n translation\(translation)\n verseNumber\(verseNumber)\n verseContent\(verseContent)\n wordForWord\(wordForWord)")
            
            if (!(self.verses.contains(where: { $0.number == currentverse.number }))) {
                debugPrint("IT DOES NOT CONTAINS \(currentverse.number!)")
                self.verses.insert(currentverse, at: i)
                self.added = true
            }
            else{
                debugPrint("IT CONTAINS")
            }
            i+=1
            
//            if (!prefetch){
//                self.collectionView?.reloadData()
//            }
            debugPrint("BBBBBB*** \(self.verses.count)")
            ActivityIndicator.shared.hideProgressView()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        debugPrint("CCCCCC*** \(self.verses.count)")
        
    }
    
    
    @IBAction func didBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    //MARK: TableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int{
        switch self.VisibleCellIndexPath() {
        case self.number-1:
            return 1
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(20)
        default:
            return CGFloat(0)
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 30.0))
        sectionHeaderView.layer.backgroundColor = UIColor.white.cgColor
        let label = UILabel(frame: CGRect(x: 15.0, y: 5.0, width: self.view.frame.width, height: 17.0))
        
        label.textColor = ColorCode().appThemeColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        switch section {
        case 0:
            label.text = nil
        case 1:
            label.text = "Next Verse"
            sectionHeaderView.addSubview(label)
        default:
            label.text = nil
            
        }
        return sectionHeaderView
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Next Verse"
            
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        tableView.sectionHeaderHeight = CGFloat(integerLiteral: 30)
        tableView.sectionFooterHeight = CGFloat(integerLiteral: 10)
        switch section{
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        debugPrint("AA gya function")
        switch indexPath.section {
        case 0:
            tableView.allowsSelection = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "VerseContentTableViewCell", for: indexPath) as! VerseContentTableViewCell
            switch indexPath.row {
            case 0:
                cell.verseCellTitleLabel?.text = "Word for word"
                cell.verseCellContentLabel?.text = currentVerse?.wordForWord
            case 1:
                cell.verseCellTitleLabel?.text = "Translation"
                cell.verseCellContentLabel?.text = currentVerse?.translation
            case 2:
                cell.verseCellTitleLabel?.text = "Purport"
                cell.verseCellContentLabel?.text = currentVerse?.purport
            default:
                cell.verseCellTitleLabel?.text = ""
                cell.verseCellContentLabel?.text = ""
            }
            return cell
        case 1:
            tableView.allowsSelection = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterVerseTableViewCell", for: indexPath) as! ChapterVerseTableViewCell
            cell.verseHeadingLabel.text = "Verse" + " " + "\((nextVerse?.number)!)"
            cell.verseTranlsationLabel.text = nextVerse?.translation
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterVerseTableViewCell", for: indexPath) as! ChapterVerseTableViewCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func VisibleCellIndexPath()->Int{
        
        let visibleCells = collectionView?.indexPathsForVisibleItems
        for indexPath in visibleCells! {
            return indexPath.row
        }
        return 0
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}


extension ChapterVersesDisplayCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = self.view.frame.width
        let cellLength = self.view.frame.height
        
        
        let width:Double = Double(cellWidth)
        let height:Double = Double(cellLength)
        
        return CGSize(width: width, height: height)
        
        
    }
    
}
