//
//  SingleRecipeDetailsDataModel.swift
//  eSpaceIVTask
//
//  Created by Adam on 16/05/2021.
//
import Foundation

// MARK: - Welcome
struct SingleRecipeData: Codable {
    let recipe: RecipeData
}

// MARK: - Recipe
struct RecipeData: Codable {
    let publisher: String
    let ingredients: [String]
    let sourceURL: String
    let recipeID: String
    let imageURL: String
    let socialRank: Int
    let publisherURL: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case publisher, ingredients
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
        case title
    }
}
