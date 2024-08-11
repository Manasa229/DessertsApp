import SwiftUI

struct MealModel: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}
