//
//  ViewController.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 19/12/22.
//

import UIKit

//enum ViewState {
//    case tableView,collectionView
//}

class YourNotesController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let dbHelper = DataBaseHelper()
    
    let sectionArray = Priority.allCases
//    var viewState = ViewState.tableView
    
    lazy var addButton = {
        
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        
        return button
  
        
    }()
    
    
    lazy var notesTable = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(YourNotesCell.self, forCellReuseIdentifier: "cell")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "header")
    
        return tableView
    }()
    
    
    lazy var notesCollection = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NotesViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
     
        return collectionView
        
    }()
    
//    lazy var listBarButton = {
//
//        let rightBarButton = UIBarButtonItem()
//        rightBarButton.image = UIImage(systemName: "rectangle.grid.2x2")
//
//        return rightBarButton
//    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Your Notes"
        
    
        
//        listBarButton.action = #selector(showCollectionTableView)
//        listBarButton.target = self
//        navigationItem.setRightBarButton(listBarButton, animated: true)
        
        view.addSubview(notesTable)
        view.addSubview(addButton)
      
        notesTable.delegate = self
        notesTable.dataSource = self
        
//        notesCollection.delegate = self
//        notesCollection.dataSource = self
        
        setTableViewConstraints()
        setButtonConstraints()
        
        addButton.addTarget(self, action: #selector(addNewNote), for: .touchUpInside)
        
    }
    
  
    
//    @objc func showCollectionTableView() {
//
//        switch viewState {
//
//        case .tableView:
//
//            notesTable.removeFromSuperview()
//            view.addSubview(notesCollection)
//            notesCollection.reloadData()
//
//            view.bringSubviewToFront(addButton)
//
//            setCollectionViewConstraints()
//            viewState = .collectionView
//
//            listBarButton.image = UIImage(systemName: "rectangle.grid.1x2")
//
//        case .collectionView:
//
//            notesCollection.removeFromSuperview()
//            view.addSubview(notesTable)
//            notesTable.reloadData()
//
//            view.bringSubviewToFront(addButton)
//
//            setTableViewConstraints()
//            viewState = .tableView
//
//            listBarButton.image = UIImage(systemName: "rectangle.grid.2x2")
//
//        }
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        switch viewState {
//        case .tableView :
            notesTable.reloadData()
//        case .collectionView :
//            notesCollection.reloadData()
//        }
       
       
    }
    
    func setCollectionViewConstraints() {
      
        NSLayoutConstraint.activate([
            notesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notesCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            notesCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }
 
    func setTableViewConstraints() {
        
        NSLayoutConstraint.activate([
            notesTable.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            notesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            notesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setButtonConstraints() {
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 70),
            ])
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Hiyah")
    }
    
    @objc func addNewNote() {
        navigationController?.pushViewController(AddItemVc(state: .ADD), animated: true)
    }
    
    
    func quickReadNote(_ title:String,_ content:String,_ date:String) {
        
        let viewController = AddItemVc(state: .VIEW)
        
     
     
        viewController.setTitleAndContent(title,content,date)
        viewController.modalPresentationStyle = .formSheet

        
        present(viewController, animated: true)
        
    }
}


extension YourNotesController: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(#function)
       
        return dbHelper.readNotes()[sectionArray[section]]?.count ?? 0
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! YourNotesCell
        let note = dbHelper.readNotes()[sectionArray[indexPath.section]]?[indexPath.row]
        cell.setTitleAndDesc(note?.title ?? "" ,note?.content ?? "",DateFormatHelper.shared.getStringFromDate(note?.createdOn ?? Date()))
        return cell
        
    }
    

 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let priority = Priority.allCases
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! Header
        cell.setText(priority[section])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       let cell  =  tableView.cellForRow(at: indexPath) as! YourNotesCell
        quickReadNote(cell.titleLabel.text ?? "", cell.descriptionLabel.text ?? "",cell.date ?? "ll")
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      
        let delete = UIContextualAction(style: .normal, title: "") { (action,view,completion) in
        
            guard let note = self.dbHelper.readNotes()[self.sectionArray[indexPath.section]]?[indexPath.row] else {
                return
            }
             
            self.dbHelper.deleteNotes(note.id)
        
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completion(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: "") {
            (action,view,completion) in
            
            guard let noteAtindex = self.dbHelper.readNotes()[self.sectionArray[indexPath.section]]?[indexPath.row] else {
            
                return
            }
            
            self.dbHelper.deleteNotes(noteAtindex.id)
            
            self.dbHelper.insertNotes(Notes(id: noteAtindex.id, title: noteAtindex.title, content: noteAtindex.content, priority: .pinned, date: noteAtindex.createdOn))
            
            tableView.reloadData()
        }
        
        edit.image = UIImage(systemName: "pin")
        edit.backgroundColor = .systemBlue
        
        delete.image = UIImage(systemName: "delete.left.fill")
        delete.backgroundColor = .systemPink
        
        if sectionArray[indexPath.section] == .pinned {
           return UISwipeActionsConfiguration(actions: [delete])
        } else {
            return UISwipeActionsConfiguration(actions: [delete,edit])
        }
  
    }
    
   
}


//
//extension YourNotesController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 6
//
//    }
//
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return sectionArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NotesViewCell
//        let note = DataBase.sharedDb.noteList[sectionArray[indexPath.section]]?[indexPath.row]
//        cell.setTitleAndDescription(note?.title ?? "", note?.content ?? "",DateFormatHelper.shared.getStringFromDate(note?.createdOn ?? Date()))
//
//        return cell
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        UIEdgeInsets(top: 10, left:40, bottom: 10, right: 40)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 150, height: 150)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let cell = collectionView.cellForItem(at: indexPath) as! NotesViewCell
//
//        quickReadNote(cell.titleLabel.text ?? "", cell.descriptionLabel.text ?? "" ,cell.date ?? "")
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//      let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath) as! HeaderReusableView
//       cell.setText(sectionArray[indexPath.section])
//
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        CGSize(width: view.bounds.width, height: 50)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
//
//        guard indexPaths.isEmpty == false else {
//            return nil
//        }
//
//        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {
//            (action)->UIMenu? in
//            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
//
//                DataBase.sharedDb.noteList[self.sectionArray[indexPaths[indexPaths.startIndex].section]]?.remove(at: indexPaths[indexPaths.startIndex].row)
//                collectionView.deleteItems(at: indexPaths)
//                        }
//            print(indexPaths)
//
//            return UIMenu(title: "OPTIONS", image: nil, identifier: nil, options: .destructive, children: [delete])
//
//        }
//
//        return context
//    }
//}




//extension   YourNotesController:UIViewControllerTransitioningDelegate {
//
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//
//        CustomNotesPresentationController(presentedViewController: presented, presenting: presenting)
//
//    }
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return ScaleAnimator()
//    }
//
//}







