//
//  AddItemVc.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 19/12/22.
//

import UIKit


enum State {
    case ADD
    case VIEW
}

class AddItemVc: UIViewController,UITextFieldDelegate {
    
    let databaseHelper = DataBaseHelper()
    
    func setTitleAndContent(_ title:String,_ content:String,_ date:String) {
        
        self.createdOntextLabel.text = date
        self.titleLabel.text = title
        self.editTextView.text = content
        
    }
    
    var state:State
    
    init(state: State) {
        self.state = state
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    lazy var createdOntextLabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        
        return label
        
    }()
    
    lazy var titleLabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 15)
        label.text = "Sample Text"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    
    
    lazy var titleField = {
        
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 0.75
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.cornerRadius = 4
        field.placeholder = "Add Title"
        field.font  = .systemFont(ofSize: 15, weight: .bold)
        
        return field
        
    }()
    
    
    lazy var setPrioritySwitch = {
        
        let switcher = UISwitch()
        switcher.onTintColor = .systemPink
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.contentMode = .center
        switcher.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        return switcher
        
    }()
 
    
    lazy var editTextView = {
        
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18)
        return view
        
    }()
    
    func emptyTextFieldAlert() {
      
        let alert = UIAlertController(title: "Empty title", message: "the title field of a note cannot be Empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: .cancel))
        present(alert, animated: true)
    }
    

    @objc func addItem() {
        
        guard let title = titleField.text,title.isEmpty == false else {
            emptyTextFieldAlert()
            return
        }
        
        let priotity:Priority
        
        if setPrioritySwitch.isOn {
            priotity = .high
        } else {
            priotity = .medium
        }
        
        DataBase.sharedDb.addNotes(title,editTextView.text, priotity)
      
        let note = Notes(title: title, content: editTextView.text, priority: priotity)
       
        databaseHelper.insertNotes(note)
        
        
        print(DataBase.sharedDb.noteList)
        
        navigationController?.popViewController(animated: true)
    }
    

    @objc func changeColor(_ sender: UISwitch) {
        
        if setPrioritySwitch.isOn {
            titleField.textColor = .systemPink
            titleField.tintColor  = .systemPink
            titleField.layer.borderColor = UIColor.red.cgColor
        } else
        {
            titleField.textColor = .black
            titleField.tintColor  = .black
            titleField.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        switch(self.state) {
        case .ADD:
        
            self.title = "Add Item"
            
            view.addSubview(titleField)
            view.addSubview(editTextView)

            let button = UIBarButtonItem(customView: setPrioritySwitch)
            let button2 = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addItem))
            navigationItem.setRightBarButtonItems([button2,button], animated: true)
            self.setConstraintsforAddView()
    
        case .VIEW:
            
            view.addSubview(createdOntextLabel)
            view.addSubview(titleLabel)
            view.addSubview(editTextView)
            
            editTextView.isEditable = false
            setConstraintsForQuickView()
        }
    }
    
    
    
    
    
    
    func setConstraintsForQuickView() {
        NSLayoutConstraint.activate([
            
            createdOntextLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            createdOntextLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            createdOntextLabel.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.05),
            
            titleLabel.topAnchor.constraint(equalTo: createdOntextLabel.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo:view.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo:view.heightAnchor,multiplier: 0.05),
            
            
            editTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            editTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20)
            
            
        ])
    }
        
        
        func setConstraintsforAddView() {
            NSLayoutConstraint.activate([
                
                titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 5),
                titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5),
                titleField.bottomAnchor.constraint(equalTo: editTextView.topAnchor),
                
                
                editTextView.topAnchor.constraint(equalTo: titleField.bottomAnchor),
                editTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                editTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                editTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                
                
            ])
        }
    
}
