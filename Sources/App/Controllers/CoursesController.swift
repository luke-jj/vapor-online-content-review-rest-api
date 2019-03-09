import Vapor
import Fluent

struct CoursesController: RouteCollection {

    func boot(router: Router) throws {
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
    }
}
