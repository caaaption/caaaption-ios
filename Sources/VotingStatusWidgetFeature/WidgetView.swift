import SwiftUI
import WidgetHelpers
import WidgetKit

public struct VotingStatusWidgetView: View {
  public var entry: Entry

  public init(entry: Entry) {
    self.entry = entry
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("MEMBERSHIP MECHANIC UPGRADE")
        .bold()

      Divider()

      VStack(alignment: .leading, spacing: 2) {
        VStack(alignment: .leading, spacing: 0) {
          Text("FOR - APPROVE CHANGE 72%")
            .foregroundColor(.green)
            .bold()

          ProgressBar(progress: 0.72, primaryColor: .green)
        }

        VStack(alignment: .leading, spacing: 0) {
          Text("AGAINST - DO NOT APPROVE CHANGE 27%")

          ProgressBar(progress: 0.27, primaryColor: .gray)
        }

        VStack(alignment: .leading, spacing: 0) {
          Text("ABSTAIN 1%")

          ProgressBar(progress: 0.01, primaryColor: .gray)
        }
      }
      .font(.caption)

      Divider()

      updatedAt
        .foregroundColor(.secondary)
        .font(.caption)
    }
    .padding(.all, 12)
  }

  var updatedAt: some View {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let dateString = dateFormatter.string(from: entry.date)
    return Text("Updated at \(dateString)")
  }
}

struct VotingStatusWidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetPreview([.systemMedium]) {
      VotingStatusWidgetView(
        entry: Entry(date: Date())
      )
    }
  }
}
