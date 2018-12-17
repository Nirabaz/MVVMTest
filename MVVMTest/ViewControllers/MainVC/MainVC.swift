//
//  ViewController.swift
//  MVVMTest
//
//  Created by Mykhailo Zabarin on 12/13/18.
//  Copyright © 2018 Mykhailo Zabarin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    
    //MARK: - Weak Variables
    
    weak var searchView: UIView!
    weak var searchField: UITextField!
    weak var searchBtn: UIButton!
    weak var tableView: UITableView!
    //MARK: - Private Variables
    
    private var mainVCViewModel = MainVCViewModel()
    
    //MARK: - Internal Variables
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        mainVCViewModel.reloadImagesList = {[weak self] in
            guard let StrongSelf = self else { return }
            StrongSelf.tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    //MARK: - Private Functions
    
    private func prepareUI() {
        
        self.view.backgroundColor = UIColor.white
        addSearchView()
        addSearchButton()
        addSearchField()
        addTableView()
    }
    
    private func addSearchView() {
        
        let sView = UIView()
        view.addSubview(sView)
        sView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            sView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            sView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            sView.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        searchView = sView
    }
    
    private func addSearchButton() {
        
        let sButton = UIButton()
        searchView.addSubview(sButton)
        sButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -8),
            sButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            sButton.heightAnchor.constraint(equalToConstant: 30),
            sButton.widthAnchor.constraint(equalToConstant: 46)
            ])
        
        searchBtn = sButton

        searchBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        searchBtn.setTitleColor(UIColor(red: 0.22, green: 0.33, blue: 0.53, alpha: 1), for: .normal)
        searchBtn.setTitle("Search", for: .normal)
        searchBtn.addTarget(self, action: #selector(searchImage), for: .touchUpInside)
    }
    
    private func addSearchField() {
        
        let sTField = UITextField()
        searchView.addSubview(sTField)
        sTField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sTField.trailingAnchor.constraint(equalTo: searchBtn.leadingAnchor, constant: -8),
            sTField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),
            sTField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            sTField.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        searchField = sTField
        searchField.borderStyle = .roundedRect
    }
    
    private func addTableView() {
        
        let tView = UITableView()
        view.addSubview(tView)
        tView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 0),
            tView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        tableView = tView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @objc private func searchImage(){
        mainVCViewModel.searchImages(str: searchField.text!, viewForProgressHud: self.view)
    }
    //MARK: - Internal Functions
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVCViewModel.ImageItemArray != nil ? mainVCViewModel.ImageItemArray!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
