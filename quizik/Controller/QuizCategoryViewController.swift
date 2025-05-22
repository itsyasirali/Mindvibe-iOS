//
//  QuizCategoryViewController.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import UIKit

class QuizCategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var array = ["First Cell", "Second Cell", "Third Cell", "Fourth Cell", "Fifth Cell"]
    
    var category_array: [TriviaCategory]?
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: nil, message: "Loading Categories....", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: false, completion: nil)
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 5
        categoryCollectionView.setCollectionViewLayout(layout, animated: true)
        
        NetworkManagerClass().fetchCategories(){
            [weak self] (category) in
            
            self?.category_array = category
            print("_response is :", self!.category_array!);
            if self!.category_array != nil{
                self!.updateCategoryView()
            }
        }
    }
    
    func updateCategoryView() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.categoryCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category_array?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! QuizCategoryCollectionViewCell
        print("The array is: ", array)
        if let  categoryName = category_array![indexPath.row].name , category_array != nil {
            cell.categoryLabel.text = categoryName
            cell.categoryImage.image = UIImage(named: imageNameForCategory(categoryName))
        }
        cell.shadowDecorate()        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.category_array != nil {
           let selectedCategoryId = self.category_array![indexPath.row].id
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            vc.category_id = "\(selectedCategoryId ?? 0)"
            self.navigationController?.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
                    let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

        return CGSize(width:widthPerItem, height:widthPerItem)
    }
}

extension QuizCategoryViewController {
    func imageNameForCategory(_ category: String) -> String {
        switch category {
        case "General Knowledge": return "general_knowledge"
        case "Entertainment: Books": return "books"
        case "Entertainment: Film": return "movie"
        case "Entertainment: Music": return "music"
        case "Entertainment: Musicals & Theatres": return "theatres"
        case "Entertainment: Television": return "television"
        case "Entertainment: Video Games": return "vediogame"
        case "Entertainment: Board Games": return "boardgames"
        case "Science: Computers": return "computer"
        case "Science & Nature": return "nature"
        case "Science: Mathematics": return "math"
        case "Mythology": return "mythology"
        case "Geography": return "geography"
        case "Sports": return "sports"
        case "Politics": return "politics"
        case "History": return "history"
        case "Art": return "art"
        case "Celebrities": return "celebrity"
        case "Animals": return "animals"
        case "Vehicles": return "vehical"
        case "Entertainment: Comics": return "comic"
        case "Science: Gadgets": return "gadgets"
        case "Entertainment: Japanese Anime & Manga": return "anime"
        case "Entertainment: Cartoon & Animations": return "carton"
        default: return "category_image"
        }
    }

}
