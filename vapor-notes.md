# Vapor Notes
    vapor new 'projectname'                 create new vapor project

    vapor xcode -y                          generate a xcode project based on
                                            the new vapor project

## Project Structure

    Package.resolved Package.swift          swift-tools package manager files

    Public

    Sources                                 source code

    Tests

    could.yml                               config file for deploying to the
                                            vapor cloud

    .circleci                               config file for CI



    Sources/Run/main.swift                  this file runs app()
    Sources/App/app.swift                   app() is the main function

    Sources/App/boot.swift                  boot() is called after app(), but
                                            before the application is running

    Sources/App/configure.swift             configure and change services, models

    Sources/App.routes.swift                add resource routes

## Commands
Only create and delete files from the commandline with the vapor utility.

Xcode: Select the `Run` scheme and press `cmd + r` to run the app.

    vapor build && vapor run                run the app from the commandline



## Async Request/Response in Swift
Swift does not have built-in concurrency features, so Vapor uses the custom
*Async* module.

**Future** - A value that will eventually be available

### Working with Futures

    flatMap(to:)                returns another future
    map(to:)                    can return any other type but a future
    transform(to:)              returns a entirely new future
