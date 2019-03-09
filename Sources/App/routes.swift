import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }

    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // POST /api/courses
    // Create new course. Course info is in the json body.
    router.post("api", "courses") { req -> Future<Course> in
        // decode the json body of the POST request into a Course object
        // the underlying course object of the future is then passed to the
        // flatMap function, each course is then saved
        return try req.content.decode(Course.self)
                              .flatMap(to: Course.self) { course in
            return course.save(on: req)
        }
    }

    // GET /api/courses
    // return all courses
    router.get("api", "courses") { req -> Future<[Course]> in
        return Course.query(on: req).all()
    }

    // GET /api/courses/:courseId
    // return a single course
    router.get("api", "courses", Course.parameter) { req -> Future<Course> in
        return try req.parameters.next(Course.self)
    }

    // PUT /api/courses/:courseId
    // update a course
    router.put("api", "courses", Course.parameter) { req -> Future<Course> in
        return try flatMap(
            to: Course.self,
            req.parameters.next(Course.self),
            req.content.decode(Course.self)) { course, updateCourse in
                        course.name = updateCourse.name
                        course.url = updateCourse.url

                        return course.save(on: req)
        }
    }

    // DELETE /api/courses/:courseId
    // Delete a single course entity
    // Return '204 no content' status if successful
    router.delete("api", "courses", Course.parameter) { req -> Future<HTTPStatus> in
        return try req.parameters.next(Course.self).flatMap(to: HTTPStatus.self) { course in
            return course.delete(on: req).transform(to: HTTPStatus.noContent)
        }
    }


    // POST /api/courses/:courseId/reviews
    // Create a new review for a course
    // Review info in JSON body
    router.post("api", "courses", Course.parameter, "reviews") { req -> Future<Review> in
        return try flatMap(
            to: Review.self,
            req.parameters.next(Course.self),
            req.content.decode(Review.self)) { course, review in

                guard course.id == review.courseID else {
                    throw Abort(.badRequest, reason: "Course ID specified in JSON does not match")
                }

                return review.save(on: req)
            }
    }

    // GET /api/courses/:courseId/reviews
    // return all reviews for a course
    router.get("api", "courses", Course.parameter, "reviews") { req -> Future<[Review]> in
        return try req.parameters.next(Course.self).flatMap(to: [Review].self) { course in
            try course.reviews.query(on: req).all()
        }
    }


    // GET /api/courses/:courseId/reviews/:reviewId
    // return a single review
    router.get("api", "courses", Course.parameter, "review", Int.parameter) { req -> Future<Review> in
        return try req.parameters.next(Course.self).flatMap(to: Review.self) { course in
            let reviewId = try req.parameters.next(Int.self)
            return try course.reviews.query(on: req)
                    .filter(\Review.id == reviewId)
                    .first()
                    .map(to: Review.self) { filteredReview in
                        guard let filteredReview = filteredReview else {
                            throw Abort(.notFound, reason: "No review available for specified ID");
                        }
                        return filteredReview
            }
        }
    }


    // Example of configuring a controller
    /* let todoController = TodoController() */
    /* router.get("todos", use: todoController.index) */
    /* router.post("todos", use: todoController.create) */
    /* router.delete("todos", Todo.parameter, use: todoController.delete) */
}
