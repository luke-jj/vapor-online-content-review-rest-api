import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let coursesController = CoursesController()
    try router.register(collection: coursesController)

    let reviewController = ReviewController()
    try router.register(collection: reviewController)


    // Basic "It works" example
    router.get { req in
        return "It works!"
    }

    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }






    // Example of configuring a controller
    /* let todoController = TodoController() */
    /* router.get("todos", use: todoController.index) */
    /* router.post("todos", use: todoController.create) */
    /* router.delete("todos", Todo.parameter, use: todoController.delete) */
}
