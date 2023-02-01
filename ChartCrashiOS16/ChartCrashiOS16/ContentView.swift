import SwiftUI
import Charts

struct ContentView: View {
	var body: some View {
		ContainerChart {
			RuleMark(x: .value("time", 2))
			RuleMark(x: .value("time", 3))
			RuleMark(x: .value("time", 4))
		}
	}
}

struct ContainerChart<Content>: View where Content: ChartContent {
	var content: () -> Content

	var body: some View {
		Chart {
			RuleMark(x: .value("time", 0))
			content()
		}
	}

	init(@ChartContentBuilder content: @escaping () -> Content) {
		self.content = content
	}
}
