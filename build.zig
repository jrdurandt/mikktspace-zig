const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.addModule("mikktspace", .{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .pic = true,
        .sanitize_c = false,
    });

    const lib = b.addLibrary(.{
        .name = "mikktspace",
        .root_module = lib_mod,
        .linkage = .static,
    });

    const deps = b.dependency("MikkTSpace", .{});
    lib.addIncludePath(deps.path("."));
    lib.installHeadersDirectory(deps.path("."), "", .{});
    lib.addCSourceFile(.{ .file = deps.path("mikktspace.c") });

    b.installArtifact(lib);
}
