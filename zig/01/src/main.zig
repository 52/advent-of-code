const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Part 1 Solution:: {}\n", .{try a()});
    try stdout.print("Part 2 Solution:: {}\n", .{try b()});
}

fn a() !i32 {
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var _reader = std.io.bufferedReader(file.reader());
    var reader = _reader.reader();
    var buf: [1024]u8 = undefined;

    var max: i32 = 0;
    var curr: i32 = 0;

    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
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

fn b() !i32 {
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var _reader = std.io.bufferedReader(file.reader());
    var reader = _reader.reader();
    var buf: [1024]u8 = undefined;

    var map = [3]i32{ 0, 0, 0 };
    var curr: i32 = 0;

    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
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
