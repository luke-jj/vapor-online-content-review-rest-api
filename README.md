# Online Review REST API (Vapor framework)

## Installation

### macOS
Install the swift toolchain, either by installing the Xcode IDE or its command
line tools. The following command will finish the installation by installing
the necessary toolchain (on macOS):

    xcode-select --install

Check that Swift and the swift toolchain is correctly installed:

    eval "$(curl -sL check.vapor.sh)"

Next the Vapor framework has to be installed:

    brew tap vapor/homebrew-tap
    brew update
    brew install vapor

If you do not have the homebrew package manager see
[vapor](https://vapor.codes/) for other installation options.

### Linux
Add Vapors apt repository. You can find it by querying this resource:

    eval "$(curl -sL https://apt.vapor.sh)"

Install Swift and Vapor:

    sudo apt-get install swift vapor

Check that Swift and the swift toolchain is correctly installed:

    eval "$(curl -sL check.vapor.sh)"

If the wep app is meant to be run on a docker container, add the following line
to the dockerfile to get the apt repo:

    RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"

<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>
