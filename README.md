# NetworkSpeedTesting

## Overview
NetworkSpeedTesting is a SwiftUI-based application that tests network access performance using Apple's `URLSessionConfiguration`. It provides an intuitive interface to measure network request times under different conditions: expensive and non-expensive network access.

## Features
- Test network speed with or without expensive network access.
- Displays test results in an easy-to-read format.
- Provides a progress indicator while testing is in progress.
- Uses Swift Concurrency (`async/await`) for smooth asynchronous execution.

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/sudhi001/ExpensiveNetworkAccessTest.git
   ```
2. Open the project in Xcode.
3. Build and run the project on a simulator or device.

## Usage
1. Launch the app.
2. Click **"Test with Expensive Network Access"** to perform a network test with `allowsExpensiveNetworkAccess` enabled.
3. Click **"Test without Expensive Network Access"** to perform a network test with `allowsExpensiveNetworkAccess` disabled.
4. View the results displayed on the screen.

## Code Structure
- `ContentView.swift`: The main UI implementation that includes two test options and displays results.
- `testNetwork(allowsExpensiveNetworkAccess:)`: Function that performs the network request and measures time taken.
- `updateResult(for:with:)`: Updates the displayed result based on the test type.

## Technologies Used
- SwiftUI for UI design
- URLSession for network testing
- Swift Concurrency (`async/await`) for asynchronous operations

## Screenshots

![Screenshot](https://github.com/sudhi001/ExpensiveNetworkAccessTest/blob/main/Screenshot.png)

## License
This project is open-source and available under the [MIT License](LICENSE).

## Author
Created by **Sudhi S.** on 15/01/25.

## Contributions
Contributions are welcome! Feel free to submit a pull request or report issues.




