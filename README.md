# Picsum project

This project is written in Swift and uses Xcode as the development environment. The project's goal is to consume a public API https://picsum.photos/ making an app that shows auto reload an infinite list of images with a good collection view layout. Also opening specific image page while tapping on of images. //.

Getting Started

To get started with this project, you will need to have Xcode installed on your machine. You can download Xcode from the Mac App Store.

Once you have Xcode installed, you can clone this repository to your local machine using a Git client, such as the one built into Xcode. Alternatively, you can download a zip file of the repository and unzip it to a local directory.

<h3>Project Structure</h3>
The project is organized as follows:

piscum
- AppDelegate.swift
- SceneDelegate.swift
- Assets.xcassets
- Info.plist
- REST
    - RequestREST.plist
    - ServiceREST.plist
    - ResponseREST.plist
    - Pagination.plist
- Tab
    - TabBar.lproj
    - Picsum
        - Picsum.lproj
        - Controllers
            - PicsumController.swift
            - PicsumDetailsController.swift
        - Views
            - ImageCCell
                - ImageCCell.swift
                - ImageCCell.xib
            - HeaderRView
                - HeaderRView.swift
                - HeaderRView.xib
        - ViewModel
            - PicsumViewModel.swift
        - Models
            - Image.swift
        - Rest
            - PicsumREST.swift
    - Search
        - Search.lproj
        - Controllers
            - SearchController.swift
    - Profile
        - Profile.lproj
        - Controllers
            - ProfileController.swift
- Utlities
    - CustomSlider.swift
    - UIViewExtensions.swift


<h3>Third-party Libraries</h3>
Project makes use of several third-party libraries to enhance its functionality and improve the user experience. These libraries are installed using the Swift Package Manager, and are listed in the project's Package.swift file. The following libraries are used in the project:

- Kingfisher: This library is used for asynchronous image downloading and caching. It improves the performance of the app by allowing images to be downloaded in the background and stored on the device for future use.
- Alamofire: This library is used for networking tasks, such as making API requests and downloading data from the internet.
- SwiftyJSON: This library is used for parsing and manipulating JSON data. It provides an easy-to-use interface for working with JSON in Swift, and simplifies common tasks such as accessing values in a JSON object or converting JSON data to native Swift types.
- UIScrollView+InfiniteScroll: This library is used to add infinite scrolling behavior to a UIScrollView object. It automatically loads and displays new content as the user scrolls, allowing for a seamless and continuous browsing experience.

These libraries are essential for the project and are automatically installed when you build the project.



