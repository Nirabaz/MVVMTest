//
//  MainVCViewModel.swift
//  MVVMTest
//
//  Created by Mykhailo Zabarin on 12/14/18.
//  Copyright © 2018 Mykhailo Zabarin. All rights reserved.
//

import Foundation

class MainVCViewModel {
    
    var reloadImagesList = { () -> () in}
    
    var ImageItemArray: [ImageItemML]? = []{
        
        didSet{
            reloadImagesList()
        }
    }
    
    func addImageItemtToArr(newItem: ImageItemML) {
        ImageItemArray?.append(newItem)
    }
    
    func searchImages(str: String) {
        
        let trimmedStr = str.trimmingCharacters(in: .whitespacesAndNewlines)
        let searchStr = trimmedStr.replacingOccurrences(of: " ", with: "+")
        
        let listUrlString = "https://pixabay.com/api/?key=" + ApiKey + "&q=" + String(searchStr)
        print(listUrlString)
        let myUrl = NSURL(string: listUrlString);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET";

        let task = URLSession.shared.dataTask(with: request as URLRequest) { [weak self]
            data, response, error in
            guard let strongSelf =  self else { return }
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else { return }
                guard let answer = try PixabayAnswerML.self(from: dict) else { return }
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
