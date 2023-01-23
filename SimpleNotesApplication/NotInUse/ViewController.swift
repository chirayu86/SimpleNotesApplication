//
//  ViewController.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 26/12/22.
//

import UIKit

class ViewController: UIViewController{
    
    let sectionArray = Priority.allCases

    lazy var collectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(NotesViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }
    
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataBase.sharedDb.noteList[sectionArray[section]]?.count ?? 0
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionArray.count
    }
  
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NotesViewCell
        let note = DataBase.sharedDb.noteList[sectionArray[indexPath.section]]?[indexPath.row]
        cell.setTitleAndDescription(note?.title ?? "", note?.content ?? "",DateFormatHelper.shared.getStringFromDate(note?.createdOn ?? Date()) )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
}
