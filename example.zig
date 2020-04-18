const std = @import("std");
const ihex = @import("ihex.zig");

fn processData(x: void, offset: u32, data: []const u8) void {
    std.debug.warn("read slice @ 0x{x}: {x}\n", .{ offset, data });
}

pub fn main() !void {
    var file = try std.fs.cwd().openFile("data/example.ihex", .{ .read = true, .write = false });
    defer file.close();

    var entry_point = try ihex.parseData(file.inStream(), ihex.ParseMode{ .pedantic = true }, {}, processData);
    if (entry_point) |ep| {
        std.debug.warn("entry point: 0x{x}\n", .{ep});
    }
}