import Vapor
import FluentSQLite

final class Course: Codable {
    var id: Int? // FluenSQLite automatically sets the id
    var name: String
    var url: URL

    init(name:String, url: URL) {
        self.name = name
        self.url = url
    }
}

extension Course {
    var reviews: Children<Course, Review> {
        return children(\.courseID)
    }
}

// extensions for the FluentSQLite ORM
// configure 'migrations' in the configure.swift' file
extension Course: SQLiteModel {}
extension Course: Migration {}
// helper protocol that adds json decodation functionality
extension Course: Content {}
// provides a static property taht generates a url resource path component for
// the provided data type.
extension Course: Parameter {}

