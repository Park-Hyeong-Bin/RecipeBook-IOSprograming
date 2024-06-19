/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

struct Recipe: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var ingredients: String
    var process: [String]
    var completeImg: String
    var processImg: [String]
    
    init(id: Int, name: String, ingredients: String, process: [String],completeImg: String, processImg: [String]) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.process = process
        self.completeImg = completeImg
        self.processImg = processImg
    }

    func uiImage(size: CGSize? = nil) -> UIImage?{
        guard let image = UIImage(named: completeImg) else {
            print("Error: Image \(completeImg) not found")
            return nil
        }
        
        guard let size = size else{ return image}
        
        // context를 획득 (사이즈, 투명도, scale 입력)
        // scale의 값이 0이면 현재 화면 기준으로 scale을 잡고, sclae의 값이 1이면 self(이미지) 크기 기준으로 설정
        UIGraphicsBeginImageContext(size)

        // 이미지를 context에 그린다.
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 그려진 이미지 가져오기
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!.withRenderingMode(.alwaysOriginal)
        
        // context 종료
        UIGraphicsEndImageContext()
        return resizedImage
    }

    var image: Image {
        Image(completeImg)
    }
}

extension Recipe{
    static func toDict(recipe: Recipe) -> [String: Any]{
        var dict = [String: Any]()
        
        dict["id"] = recipe.id
        dict["name"] = recipe.name
        dict["ingredients"] = recipe.ingredients
        dict["process"] = recipe.process
        dict["completeImg"] = recipe.completeImg
        dict["processImg"] = recipe.processImg
        return dict
    }
    
    static func fromDict(dict: [String: Any]) -> Recipe{
        
        let id = dict["id"] as! Int
        let name = dict["name"] as! String
        let ingredients = dict["ingredients"] as! String
        let process = dict["process"] as! [String]
        let completeImg = dict["completeImg"] as! String
        let processImg = dict["processImg"] as! [String]

        return Recipe(id: id, name: name, ingredients: ingredients, process: process, completeImg: completeImg, processImg: processImg)
    }
}

