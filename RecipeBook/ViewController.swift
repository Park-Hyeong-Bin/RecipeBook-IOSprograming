//
//  ViewController.swift
//  RecipeBook
//
//  Created by mac033 on 6/17/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var DName: UIPickerView!
    @IBOutlet weak var Ingredients: UILabel!
    @IBOutlet weak var Process: UIPickerView!
    
    var food: [Recipe] = RecipeBook.load("recipeData.json")
    var selectedRecipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DName.dataSource = self
        DName.delegate = self
        Process.dataSource = self
        Process.delegate = self
        
        if food.count > 0{
            DName.selectRow(0, inComponent: 0, animated: true)
            updateRecipe(row: 0)
        }
    }
    
    func updateRecipe( row: Int){
        selectedRecipe = food[row]
        Ingredients.text = selectedRecipe?.ingredients
        Process.reloadAllComponents()
    }
}

extension ViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == DName{
            return food.count
        }else if pickerView == Process {
            return selectedRecipe?.process.count ?? 0
        }
        return 0
        
    }
}

extension ViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == DName{
            updateRecipe(row: row)
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == DName{
            let nameLabel = UILabel()
            nameLabel.text = food[row].name
            let imageView = UIImageView(image: food[row].uiImage())
            
            let outer = UIStackView(arrangedSubviews: [imageView, nameLabel])
            outer.axis = .vertical
            return outer
        }else if pickerView == Process{
            let stepLabel = UILabel()
            stepLabel.text = selectedRecipe?.process[row]
            let imageView = UIImageView(image: UIImage(named: selectedRecipe?.processImg[row] ?? ""))
            
            let outer = UIStackView(arrangedSubviews: [imageView, stepLabel])
            outer.axis = .vertical
            return outer
        }
        return UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.height / 2
    }
}
