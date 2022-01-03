# NetFun-ios-app
iOS app using BFF service to display processed data. The iOS demo developed in `SwiftUI` and it uses `BFF` service to show expected UI components based on the response.

## Demo
![Simulator Screen Shot - iPhone 11 - 2022-01-03 at 20 10 38](https://user-images.githubusercontent.com/21213161/147944098-4762a24c-93e2-46c9-b19f-6579e3b193a5.png)


## Setup
1. Clone repo.
2. Open iOS project.
3. Wait for Swift Package dependecies to resolve.
4. Backend Setup: Use package [NetFun-Backend](https://github.com/max6363/NetFun-Backend) for server support for the ios app. Follow instructions in README file.
5. `NetFun-Backend` is required to call APIs and receive expected responses.
6. Set `baseURL`. Go to `ServiceManager` and update the `baseURL` if required.
7. Run the app in device or simulator.
