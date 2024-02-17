//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Smita Kankayya on 17/02/24.
//

import UIKit

class RecipesViewController: UIViewController {
    
    @IBOutlet var recipeTableView: UITableView!
    
    var recipe = RecipeDM(recipes: [])
    var recipeDetailsViewController : RecipeDetailsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerWithXIBTableView()
        initializeTableView()
        jsonParsingUsingDecoder()
    }
    
    func registerWithXIBTableView(){
        let uiNib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        self.recipeTableView.register(uiNib, forCellReuseIdentifier: "RecipeTableViewCell")
    }
    
    func initializeTableView(){
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        
    }
    
    func jsonParsingUsingDecoder(){
        let url = URL(string: "https://dummyjson.com/recipes")
        let urlRequest = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let jsonDecoder = JSONDecoder()
            self.recipe = try! jsonDecoder.decode(RecipeDM.self, from: data!)
            print(self.recipe)
            
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

//MARK : UITableViewDataSource
extension RecipesViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.recipes!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipeTableViewCell = self.recipeTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell
        recipeTableViewCell?.recipeImage.kf.setImage(with: URL(string: recipe.recipes![indexPath.row].image))
        recipeTableViewCell?.recipeRatingLabel.text = ("Rating : \(recipe.recipes![indexPath.row].rating)")
        recipeTableViewCell?.recipeReviewCountLabel.text = ("Review Count : \(recipe.recipes![indexPath.row].reviewCount)")
        recipeTableViewCell?.RecipeTagsLabel.text = ("Tags : \(recipe.recipes![indexPath.row].tags.joined(separator: ","))")
        return recipeTableViewCell!
    }
    
}

//MARK : UITableViewDelegate
extension RecipesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController
        recipeDetailsViewController?.recipeContainer = recipe.recipes![indexPath.row]
        navigationController?.pushViewController(recipeDetailsViewController!, animated: true)
    }
}
