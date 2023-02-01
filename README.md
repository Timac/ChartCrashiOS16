
This sample project causes a runtime crash with Swift Charts on iOS 16.3.

## Reproduce

- Download the sample Xcode project
- Compile and run in the iPhone 14 Pro Simulator

Result: You get a runtime crash


## Source

The crash is caused by these 30 lines of code:

```
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
```


## Crashlog

```
* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x9000000000)
    frame #0: 0x000000018c023194 libswiftCore.dylib`swift::TargetMetadata<swift::InProcess>::isCanonicalStaticallySpecializedGenericMetadata() const
    frame #1: 0x000000018c02d92c libswiftCore.dylib`swift::MetadataResponse performOnMetadataCache<swift::MetadataResponse, swift_checkMetadataState::CheckStateCallbacks>(swift::TargetMetadata<swift::InProcess> const*, swift_checkMetadataState::CheckStateCallbacks&&) + 32
    frame #2: 0x000000018c02d900 libswiftCore.dylib`swift_checkMetadataState + 32
    frame #3: 0x0000000103d8d0c8 Charts`___lldb_unnamed_symbol7303 + 44
    frame #4: 0x000000018c03045c libswiftCore.dylib`swift::MetadataCacheEntryBase<(anonymous namespace)::GenericCacheEntry, void const*>::doInitialization(swift::MetadataWaitQueue::Worker&, swift::MetadataRequest) + 280
    frame #5: 0x000000018c024d0c libswiftCore.dylib`_swift_getGenericMetadata(swift::MetadataRequest, void const* const*, swift::TargetTypeContextDescriptor<swift::InProcess> const*) + 1624
    frame #6: 0x0000000103ba1dbc Charts`___lldb_unnamed_symbol1347 + 40
    frame #7: 0x0000000103d8b18c Charts`type metadata accessor for Charts.BuilderPair + 16
    frame #8: 0x0000000103d89ef4 Charts`static Charts.BuilderPair< where τ_0_0: Charts.ChartContent, τ_0_1: Charts.ChartContent>._layoutChartContent(Charts.BuilderPair<τ_0_0, τ_0_1>, Charts._ChartContentLayoutInputs) -> () + 120
    frame #9: 0x0000000103d8ac74 Charts`___lldb_unnamed_symbol7230 + 32
    frame #10: 0x0000000103d89b0c Charts`___lldb_unnamed_symbol7215 + 176
    frame #11: 0x0000000103d89b60 Charts`___lldb_unnamed_symbol7218 + 12
    frame #12: 0x0000000103c0a5d8 Charts`___lldb_unnamed_symbol2659 + 84
    frame #13: 0x0000000103c0a578 Charts`___lldb_unnamed_symbol2658 + 84
    frame #14: 0x0000000103c24254 Charts`___lldb_unnamed_symbol3019 + 44
    frame #15: 0x0000000103c0a514 Charts`___lldb_unnamed_symbol2657 + 48
    frame #16: 0x0000000103c24218 Charts`___lldb_unnamed_symbol3018 + 44
    frame #17: 0x000000018be49f68 libswiftCore.dylib`Swift.withUnsafePointer<τ_0_0, τ_0_1>(to: inout τ_0_0, _: (Swift.UnsafePointer<τ_0_0>) throws -> τ_0_1) throws -> τ_0_1 + 20
    frame #18: 0x000000018c00a89c libswiftCore.dylib`Swift.withUnsafeMutablePointer<τ_0_0, τ_0_1>(to: inout τ_0_0, _: (Swift.UnsafeMutablePointer<τ_0_0>) throws -> τ_0_1) throws -> τ_0_1 + 12
    frame #19: 0x0000000103c0a4c4 Charts`___lldb_unnamed_symbol2656 + 172
    frame #20: 0x0000000103d8a41c Charts`___lldb_unnamed_symbol7225 + 96
    frame #21: 0x0000000103bfc928 Charts`___lldb_unnamed_symbol2551 + 268
    frame #22: 0x0000000103be3ee0 Charts`___lldb_unnamed_symbol2078 + 508
    frame #23: 0x0000000103bfc7fc Charts`___lldb_unnamed_symbol2550 + 232
    frame #24: 0x0000000103d8a394 Charts`___lldb_unnamed_symbol7224 + 944
    frame #25: 0x0000000103d8b984 Charts`___lldb_unnamed_symbol7253 + 56
    frame #26: 0x000000018be49f48 libswiftCore.dylib`Swift.withUnsafePointer<τ_0_0, τ_0_1>(to: τ_0_0, _: (Swift.UnsafePointer<τ_0_0>) throws -> τ_0_1) throws -> τ_0_1 + 20
    frame #27: 0x0000000103d89fac Charts`static Charts.BuilderPair< where τ_0_0: Charts.ChartContent, τ_0_1: Charts.ChartContent>._layoutChartContent(Charts.BuilderPair<τ_0_0, τ_0_1>, Charts._ChartContentLayoutInputs) -> () + 304
    frame #28: 0x0000000103d8ac74 Charts`___lldb_unnamed_symbol7230 + 32
    frame #29: 0x0000000103d8afc0 Charts`___lldb_unnamed_symbol7233 + 72
    frame #30: 0x0000000103bfcbb0 Charts`___lldb_unnamed_symbol2553 + 272
    frame #31: 0x0000000103be3ee0 Charts`___lldb_unnamed_symbol2078 + 508
    frame #32: 0x0000000103bfca80 Charts`___lldb_unnamed_symbol2552 + 236
    frame #33: 0x0000000103d8af44 Charts`___lldb_unnamed_symbol7232 + 320
    frame #34: 0x0000000103d8adf0 Charts`static Charts.AnyChartContent._layoutChartContent(Charts.AnyChartContent, Charts._ChartContentLayoutInputs) -> () + 92
    frame #35: 0x0000000103e053ac Charts`___lldb_unnamed_symbol9153 + 560
    frame #36: 0x0000000103baedbc Charts`___lldb_unnamed_symbol1514 + 1540
    frame #37: 0x0000000103bb078c Charts`Charts.Chart.body.getter : some + 248
    frame #38: 0x0000000103bb2c08 Charts`___lldb_unnamed_symbol1538 + 12
    frame #39: 0x000000010833316c SwiftUI`___lldb_unnamed_symbol118421 + 28
    frame #40: 0x0000000108a11ed4 SwiftUI`___lldb_unnamed_symbol176565 + 44
    frame #41: 0x000000010833309c SwiftUI`___lldb_unnamed_symbol118420 + 1488
    frame #42: 0x0000000108a1259c SwiftUI`___lldb_unnamed_symbol176587 + 512
    frame #43: 0x00000001081753f0 SwiftUI`___lldb_unnamed_symbol104683 + 28
    frame #44: 0x000000019c38d6f8 AttributeGraph`AG::Graph::UpdateStack::update() + 512
    frame #45: 0x000000019c38ddd4 AttributeGraph`AG::Graph::update_attribute(AG::data::ptr<AG::Node>, unsigned int) + 428
    frame #46: 0x000000019c395b20 AttributeGraph`AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, unsigned char&, long) + 416
    frame #47: 0x000000019c3ab8ec AttributeGraph`AGGraphGetValue + 216
    frame #48: 0x0000000108acca38 SwiftUI`___lldb_unnamed_symbol181296 + 64
    frame #49: 0x0000000108accc08 SwiftUI`___lldb_unnamed_symbol181304 + 292
    frame #50: 0x00000001081753f0 SwiftUI`___lldb_unnamed_symbol104683 + 28
    frame #51: 0x000000019c38d6f8 AttributeGraph`AG::Graph::UpdateStack::update() + 512
    frame #52: 0x000000019c38ddd4 AttributeGraph`AG::Graph::update_attribute(AG::data::ptr<AG::Node>, unsigned int) + 428
    frame #53: 0x000000019c395b20 AttributeGraph`AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, unsigned char&, long) + 416
    frame #54: 0x000000019c3ab8ec AttributeGraph`AGGraphGetValue + 216
    frame #55: 0x00000001080b1f5c SwiftUI`___lldb_unnamed_symbol91338 + 128
    frame #56: 0x000000019c38d6f8 AttributeGraph`AG::Graph::UpdateStack::update() + 512
    frame #57: 0x000000019c38ddd4 AttributeGraph`AG::Graph::update_attribute(AG::data::ptr<AG::Node>, unsigned int) + 428
    frame #58: 0x000000019c395b20 AttributeGraph`AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, unsigned char&, long) + 416
    frame #59: 0x000000019c3ab8ec AttributeGraph`AGGraphGetValue + 216
    frame #60: 0x00000001080b37b0 SwiftUI`___lldb_unnamed_symbol91365 + 196
    frame #61: 0x000000019c38d6f8 AttributeGraph`AG::Graph::UpdateStack::update() + 512
    frame #62: 0x000000019c38ddd4 AttributeGraph`AG::Graph::update_attribute(AG::data::ptr<AG::Node>, unsigned int) + 428
    frame #63: 0x000000019c395b20 AttributeGraph`AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, unsigned char&, long) + 416
    frame #64: 0x000000019c3ab8ec AttributeGraph`AGGraphGetValue + 216
    frame #65: 0x000000010862f27c SwiftUI`___lldb_unnamed_symbol143580 + 92
    frame #66: 0x0000000107f19298 SwiftUI`___lldb_unnamed_symbol83248 + 64
    frame #67: 0x0000000107f17df8 SwiftUI`___lldb_unnamed_symbol83247 + 448
    frame #68: 0x00000001080d3e70 SwiftUI`___lldb_unnamed_symbol92695 + 20
    frame #69: 0x000000019c38d6f8 AttributeGraph`AG::Graph::UpdateStack::update() + 512
    frame #70: 0x000000019c38ddd4 AttributeGraph`AG::Graph::update_attribute(AG::data::ptr<AG::Node>, unsigned int) + 428
    frame #71: 0x000000019c395b20 AttributeGraph`AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, unsigned char&, long) + 416
    frame #72: 0x000000019c3ab8ec AttributeGraph`AGGraphGetValue + 216
    frame #73: 0x000000010834c620 SwiftUI`___lldb_unnamed_symbol119654 + 144
    frame #74: 0x000000010834c768 SwiftUI`___lldb_unnamed_symbol119663 + 60
    frame #75: 0x00000001081a31e0 SwiftUI`___lldb_unnamed_symbol105954 + 128
    frame #76: 0x000000019c38d6f8 AttributeGraph`AG::Graph::UpdateStack::update() + 512
    frame #77: 0x000000019c38ddd4 AttributeGraph`AG::Graph::update_attribute(AG::data::ptr<AG::Node>, unsigned int) + 428
    frame #78: 0x000000019c3952c4 AttributeGraph`AG::Graph::value_ref(AG::AttributeID, AGSwiftMetadata const*, unsigned char&) + 160
    frame #79: 0x000000019c3ab934 AttributeGraph`AGGraphGetValue + 288
    frame #80: 0x0000000108eb5930 SwiftUI`___lldb_unnamed_symbol212569 + 92
    frame #81: 0x0000000108534234 SwiftUI`___lldb_unnamed_symbol138551 + 252
    frame #82: 0x0000000108d19b04 SwiftUI`___lldb_unnamed_symbol200851 + 2120
    frame #83: 0x0000000108d17560 SwiftUI`___lldb_unnamed_symbol200731 + 348
    frame #84: 0x0000000109082370 SwiftUI`___lldb_unnamed_symbol228414 + 264
    frame #85: 0x00000001090823b4 SwiftUI`___lldb_unnamed_symbol228415 + 28
    frame #86: 0x0000000104e3b118 UIKitCore`-[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 1920
    frame #87: 0x0000000187f5f970 QuartzCore`CA::Layer::layout_if_needed(CA::Transaction*) + 440
    frame #88: 0x0000000187f6a4b4 QuartzCore`CA::Layer::layout_and_display_if_needed(CA::Transaction*) + 128
    frame #89: 0x0000000187e97a74 QuartzCore`CA::Context::commit_transaction(CA::Transaction*, double, double*) + 440
    frame #90: 0x0000000187ec3a24 QuartzCore`CA::Transaction::commit() + 652
    frame #91: 0x00000001049b70cc UIKitCore`__34-[UIApplication _firstCommitBlock]_block_invoke_2 + 32
    frame #92: 0x0000000180372f54 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 20
    frame #93: 0x000000018037269c CoreFoundation`__CFRunLoopDoBlocks + 364
    frame #94: 0x000000018036cec4 CoreFoundation`__CFRunLoopRun + 776
    frame #95: 0x000000018036c7a4 CoreFoundation`CFRunLoopRunSpecific + 584
    frame #96: 0x0000000188ff7c98 GraphicsServices`GSEventRunModal + 160
    frame #97: 0x000000010499e37c UIKitCore`-[UIApplication _run] + 868
    frame #98: 0x00000001049a2374 UIKitCore`UIApplicationMain + 124
    frame #99: 0x0000000108dc10d4 SwiftUI`___lldb_unnamed_symbol204132 + 164
    frame #100: 0x0000000108dc0f7c SwiftUI`___lldb_unnamed_symbol204130 + 140
    frame #101: 0x0000000108526b60 SwiftUI`static SwiftUI.App.main() -> () + 80
  * frame #102: 0x0000000102e7f508 ChartCrashiOS16`static ChartCrashiOS16App.$main(self=ChartCrashiOS16.ChartCrashiOS16App) at ChartCrashiOS16App.swift:10:1
    frame #103: 0x0000000102e7f5b0 ChartCrashiOS16`main at ChartCrashiOS16App.swift:0
    frame #104: 0x0000000103041fa0 dyld_sim`start_sim + 20
    frame #105: 0x00000001031dde50 dyld`start + 2544
```

# Tested with

- Xcode 14.2 (14C18)
- iPhone 14 Pro Simulator
- macOS 13.1 (22C65)
