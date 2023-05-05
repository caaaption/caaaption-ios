// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "caaaption",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "navigation-beta"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.1.2"),
  ]
)

// Features
package.products.append(contentsOf: [
  .library(name: "AppFeature", targets: ["AppFeature"]),
  .library(name: "WidgetSearchFeature", targets: ["WidgetSearchFeature"]),
  .library(name: "AccountFeature", targets: ["AccountFeature"]),
  .library(name: "ContributorFeature", targets: ["ContributorFeature"]),
  .library(name: "BalanceWidgetFeature", targets: ["BalanceWidgetFeature"]),
  .library(name: "VoteWidgetFeature", targets: ["VoteWidgetFeature"]),
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    "WidgetSearchFeature",
  ]),
  .target(name: "WidgetSearchFeature", dependencies: [
    "AccountFeature",
    "BalanceWidgetFeature",
  ]),
  .target(name: "AccountFeature", dependencies: [
    "ServerConfig",
    "ContributorFeature",
  ]),
  .target(name: "ContributorFeature", dependencies: [
    "GitHubClient",
    "SwiftUIHelpers",
    "UIApplicationClient",
    "PlaceholderAsyncImage",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "BalanceWidgetFeature", dependencies: [
    "BalanceWidget",
    "SwiftUIHelpers",
    "QuickNodeClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VoteWidgetFeature", dependencies: [
    "VoteWidget",
    "SwiftUIHelpers",
    "SnapshotClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

// GraphQL
package.products.append(contentsOf: [
  .library(name: "SnapshotModel", targets: ["SnapshotModel"]),
  .library(name: "SnapshotModelMock", targets: ["SnapshotModelMock"]),
])
package.targets.append(contentsOf: [
  .target(name: "SnapshotModel", dependencies: [
    .product(name: "ApolloAPI", package: "apollo-ios"),
  ]),
  .target(name: "SnapshotModelMock", dependencies: [
    "SnapshotModel",
    .product(name: "ApolloTestSupport", package: "apollo-ios"),
  ]),
])

// Client

package.products.append(contentsOf: [
  .library(name: "FirebaseClientLive", targets: ["FirebaseClientLive"]),
  .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
  .library(name: "SnapshotClient", targets: ["SnapshotClient"]),
  .library(name: "ServerConfig", targets: ["ServerConfig"]),
  .library(name: "GitHubClient", targets: ["GitHubClient"]),
  .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
  .library(name: "QuickNodeClient", targets: ["QuickNodeClient"]),
])
package.targets.append(contentsOf: [
  .target(name: "FirebaseClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "FirebaseClientLive", dependencies: [
    "FirebaseClient",
  ]),
  .target(name: "UIApplicationClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "SnapshotClient", dependencies: [
    "ApolloHelpers",
    "SnapshotModel",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "ServerConfig"),
  .target(name: "GitHubClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "UserDefaultsClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "QuickNodeClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

// Helpers

package.products.append(contentsOf: [
  .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
  .library(name: "ApolloHelpers", targets: ["ApolloHelpers"]),
])
package.targets.append(contentsOf: [
  .target(name: "SwiftUIHelpers"),
  .target(name: "ColorHex"),
  .testTarget(name: "ColorHexTests", dependencies: [
    "ColorHex",
  ]),
  .target(name: "ApolloHelpers", dependencies: [
    .product(name: "Apollo", package: "apollo-ios"),
    .product(name: "ApolloAPI", package: "apollo-ios"),
  ]),
])

// Utilities
package.products.append(contentsOf: [
  .library(name: "PlaceholderAsyncImage", targets: ["PlaceholderAsyncImage"]),
])
package.targets.append(contentsOf: [
  .target(name: "PlaceholderAsyncImage"),
])

// Widgets

package.products.append(contentsOf: [
  .library(name: "WidgetProtocol", targets: ["WidgetProtocol"]),
  .library(name: "WidgetHelpers", targets: ["WidgetHelpers"]),
  .library(name: "ArtWidget", targets: ["ArtWidget"]),
  .library(name: "BalanceWidget", targets: ["BalanceWidget"]),
  .library(name: "VotingStatusWidget", targets: ["VotingStatusWidget"]),
  .library(name: "VoteWidget", targets: ["VoteWidget"]),
  .library(name: "GasPriceWidget", targets: ["GasPriceWidget"]),
])
package.targets.append(contentsOf: [
  .target(name: "WidgetProtocol"),
  .target(name: "WidgetHelpers"),
  .target(name: "ArtWidget", dependencies: [
    "WidgetHelpers",
  ]),
  .target(name: "BalanceWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
    "QuickNodeClient",
    "UserDefaultsClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VotingStatusWidget", dependencies: [
    "WidgetHelpers",
    "SnapshotClient",
    "WidgetProtocol",
  ]),
  .target(name: "VoteWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
  ]),
  .target(name: "GasPriceWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
  ]),
])
