//
//  QuizPageViewController.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class QuizPageViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var position:Int = 0
    var pageClosed = false
    
    var collectionView: UICollectionView!
    
    let pageControl = UIPageControl()
    
    let cellId = "Cell"
    
    var textArray = [String]()
    
    var tempTextArray = [[String]]()
    
    var gifArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addCollectionView()
        addPageControl()
        
        collectionView.register(QuizPageViewControllerCell.self, forCellWithReuseIdentifier: cellId)
        
        configStatusBar()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        configStatusBarGreen()
    }
    
    func configStatusBarGreen(){
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.blue
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = UIColor.red
        }
    }
    
    func configStatusBar(){
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.white
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = UIColor.white
        }
    }
    
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach{
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    
    func setupNavigationBar(){
        let leftbuttonIcon = UIImage(named: "assist_speaker")
        let navLeftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(skipSelected))
        navLeftButton.image = leftbuttonIcon
        let navRightButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipSelected))
        self.navigationItem.title = "quiz"
        self.navigationItem.rightBarButtonItem = navRightButton
        self.navigationItem.leftBarButtonItem = navLeftButton
    }
    
    @objc func skipSelected(){
        self.dismiss(animated: true, completion: nil)
        //        delegate?.voiceAssistCompleted(position: position)
    }
    
    
    
    func addCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
    }
    
    func addPageControl(){
        self.view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        pageControl.backgroundColor = .clear
        pageControl.numberOfPages = tempTextArray.count
        pageControl.currentPage = 0
        textArray = tempTextArray[0]
        
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.green
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        print("pageControl.currentPage - ", pageControl.currentPage)
        textArray = tempTextArray[pageControl.currentPage]
        
        collectionView.reloadItems(at: [IndexPath(item: pageControl.currentPage, section: 0)])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempTextArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! QuizPageViewControllerCell
        
        cell.backgroundColor = .white
        
        
        textArray = tempTextArray[indexPath.item]
        print("pageControl.currentPage - ", pageControl.currentPage)
        if let currentIndex = collectionView.indexPathsForVisibleItems.first {
            print("currentIndex - ", currentIndex.row)
        }
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
