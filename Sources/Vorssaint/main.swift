// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit

SuperKeyMappingGuard.runIfRequestedAndExit()
Defaults.register()
NotchControlItem.keyboardLightIsSupported = { BrightnessService.keyboardLightIsSupported }
MouseAccelerationGuard.runIfRequestedAndExit()
MouseAccelerationService.recoverPendingAtLaunch()

#if VORSSAINT_DEVELOPMENT
// `--media-layout` on its own would otherwise launch the whole app, and TCC
// kills that from a shell whose host app lacks a Bluetooth usage description.
if CommandLine.arguments.contains("--notch-presentation-test") || CommandLine.arguments.contains("--media-layout") {
    NotchPresentationProbe.runAndExit()
}
#endif

if CommandLine.arguments.contains("--selftest") {
    SelfTest.runAndExit()
}
if CommandLine.arguments.contains("--sensors") {
    SensorDump.runAndExit()
}
if CommandLine.arguments.contains("--uninstall") {
    Uninstaller.runAndExit()
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
