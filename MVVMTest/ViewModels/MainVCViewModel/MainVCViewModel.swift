//
//  MainVCViewModel.swift
//  MVVMTest
//
//  Created by Mykhailo Zabarin on 12/14/18.
//  Copyright © 2018 Mykhailo Zabarin. All rights reserved.
//

import Foundation
import JGProgressHUD

class MainVCViewModel {
    
    var reloadImagesList = { () -> () in}
    
    private let hud = JGProgressHUD(style: .dark)
    
    var ImageItemArray: [ImageItemML]? = []{
        
        didSet{
            reloadImagesList()
        }
    }
    
    func addImageItemtToArr(newItem: ImageItemML) {
        ImageItemArray?.append(newItem)
    }
    
    func searchImages(str: String, viewForProgressHud: UIView) {
        
        let trimmedStr = str.trimmingCharacters(in: .whitespacesAndNewlines)
        let searchStr = trimmedStr.replacingOccurrences(of: " ", with: "+")
        
        let listUrlString = "https://pixabay.com/api/?key=" + ApiKey + "&q=" + String(searchStr)
        print(listUrlString)
        let myUrl = NSURL(string: listUrlString);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET";
        
        hud.show(in: viewForProgressHud)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [weak self]
            data, response, error in
            guard let strongSelf =  self else { return }
            if error != nil {
                print(error!.localizedDescription)
                strongSelf.hud.dismiss()
                return
            }
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else { return }
                guard let answer = try PixabayAnswerML.self(from: dict) else { return }
                strongSelf.hud.dismiss()
                if answer.hits.count > 0 {
                    let firstElement = answer.hits[0]
                } else {
                    return
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
