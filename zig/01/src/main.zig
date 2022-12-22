const std = @import("std");
const File = std.fs.File;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var file = std.fs.cwd().openFile("input.txt", .{}) catch |err| {
        try stdout.print("Error opening file: {}\n", .{err});
        return;
    };

    defer file.close();

    try stdout.print("Part 1 Solution:: {}\n", .{try a(file)});
    try file.seekTo(0);
    try stdout.print("Part 2 Solution:: {}\n", .{try b(file)});
}

fn a(file: File) !i32 {
    var _reader = std.io.bufferedReader(file.reader());
    var buf: [1024]u8 = undefined;

    var max: i32 = 0;
    var curr: i32 = 0;

    while (try _reader.reader().readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) {
            max = if (curr > max) curr else max;
            curr = 0;
            continue;
        }

        var i = try std.fmt.parseInt(i32, line, 10);
        curr = curr + i;
    }

    return max;
}

fn b(file: File) !i32 {
    var _reader = std.io.bufferedReader(file.reader());
    var buf: [1024]u8 = undefined;

    var map = [3]i32{ 0, 0, 0 };
    var curr: i32 = 0;

    while (try _reader.reader().readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) {
            var p: usize = 0;
            for (map) |_, idx| {
                if (map[idx] < map[p]) p = idx;
            }

            if (curr > map[p]) map[p] = curr;

            curr = 0;
            continue;
        }

        var i = try std.fmt.parseInt(i32, line, 10);
        curr = curr + i;
    }

    return sum(map);
}

fn sum(arr: [3]i32) i32 {
    var _sum: i32 = 0;
    for (arr) |i| _sum = _sum + i;
    return _sum;
}
