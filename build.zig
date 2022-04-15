const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const windows = b.option(bool, "windows", "create windows build") orelse false;
    const vcpkg = b.option(bool, "vcpkg", "Add vcpkg paths to the build") orelse false;

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zighttp", "src/main.zig");

    if (windows) {
        exe.setTarget(.{
            .cpu_arch = .x86_64,
            .os_tag = .windows,
            .abi = .msvc,
        });
    }

    if (vcpkg) {
        exe.addVcpkgPaths(.static) catch @panic("Cannot add vcpkg paths.");
    }
    // linkLibC() equals to linkSystemLibrary("c")
    // exe.linkLibC();
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("raylib");
    exe.linkSystemLibrary("user32");
    exe.linkSystemLibrary("gdi32");
    exe.linkSystemLibrary("shell32");
    exe.linkSystemLibrary("winmm");


    exe.setBuildMode(mode);
    // optional: for strip exe
    exe.strip = true;
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
