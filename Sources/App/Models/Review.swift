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

// extensions for the FluentSQLite ORM
// configure 'migrations' in the configure.swift' file
extension Review: SQLiteModel {}
extension Review: Migration {}

// helper protocol that adds json decodation functionality
extension Review: Content {}

// provides a static property taht generates a url resource path component for
// the provided data type.
extension Review: Parameter {}

/* extension Course: Model { */
    /* typealias Database = SQLiteDatabase */
    /* typealias ID = Int */
    /* static var idKey IDKey = \Course.id */
/* } */
