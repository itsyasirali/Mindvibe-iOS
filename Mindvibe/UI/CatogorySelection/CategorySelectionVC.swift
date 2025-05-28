//
//  CategorySelectionVC.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//
//


import UIKit
import Combine

class CategorySelectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var categoryCollectionView: UICollectionView!

    private let viewModel = QuizCategoryViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        viewModel.fetchCategories()
    }

    private func setupCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 5
        categoryCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    ActivityIndicator.show()
                case .content:
                    ActivityIndicator.hide()
                    self.categoryCollectionView.reloadData()
                case .empty:
                    ActivityIndicator.hide()
                    Toast.showToast(message: .noCategoriesFound)
                case .error(let message):
                    ActivityIndicator.hide()
                    Toast.showToast(message: message)
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - CollectionView Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .cellIdentifier, for: indexPath) as! QuizCategoryCollectionViewCell
        let category = viewModel.categories[indexPath.row]
        cell.titleLabel.text = category.name
        cell.iconImageView.image = UIImage(named: imageNameForCategory(category.name ?? .empty))
        cell.applyCardStyle()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = viewModel.categories[indexPath.row]
        guard let categoryId = category.id else { return }
        let storyboard = UIStoryboard(name: .mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: .quizViewController) as! QuizViewController
        vc.category_id = "\(categoryId)"
        self.navigationController?.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

extension CategorySelectionVC {
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
