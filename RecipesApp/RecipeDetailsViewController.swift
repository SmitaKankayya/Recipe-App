//
//  RecipeDetailsViewController.swift
//  RecipesApp
//
//  Created by Smita Kankayya on 17/02/24.
//

import UIKit
import Kingfisher

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var recipeIngredientsLabel: UILabel!
    @IBOutlet var RecipeInstructionsLabel: UILabel!
    
    var recipeContainer : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    func bindData(){
        recipeImageView.kf.setImage(with: URL(string: (recipeContainer!.image)))
        self.recipeName.text = ("Name Of Recipe :\n\(recipeContainer!.name)")
        self.recipeIngredientsLabel.text = ("Ingredients :\n\(recipeContainer!.ingredients.joined(separator: ",\n"))")
        self.RecipeInstructionsLabel.text = ("Instruction :\n\(recipeContainer!.instructions.joined(separator: "\n"))")
        

    }
}
