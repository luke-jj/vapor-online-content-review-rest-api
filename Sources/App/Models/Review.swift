import Vapor
import FluentSQLite

final class Review: Codable {
    var id: Int?            // FluenSQLite automatically sets the id
    var rating: Double
    var comment: String
    var courseID: Course.ID

    init(courseID: Course.ID, rating: Double, comment: String) {
        self.rating = rating
        self.comment = comment
        self.courseID = courseID
    }
}

extension Review: SQLiteModel {}
extension Review: Migration {}

