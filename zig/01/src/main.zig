const std = @import("std");
const testing = std.testing;

const Solution = struct {
    file: std.fs.File,

    fn init() !@This() {
        var file = try std.fs.cwd().openFile("input.txt", .{});
        return Solution{ .file = file };
    }

    fn deinit(self: @This()) void {
        self.file.close();
    }

    fn rewind(self: @This()) !void {
        try self.file.seekTo(0);
    }

    fn sum(arr: [3]i32) i32 {
        var _sum: i32 = 0;
        for (arr) |i| _sum = _sum + i;
        return _sum;
    }

    fn a(self: @This()) !i32 {
        var _reader = std.io.bufferedReader(self.file.reader());
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

    fn b(self: @This()) !i32 {
        var _reader = std.io.bufferedReader(self.file.reader());
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
};

test {
    std.testing.log_level = .debug;
    var solution = try Solution.init();
    defer solution.deinit();

    var a = try solution.a();
    try solution.rewind();
    var b = try solution.b();

    try testing.expectEqual(a, 70720);
    try testing.expectEqual(b, 207148);

    std.debug.print("\nSolution 1: {}\n", .{a});
    std.debug.print("Solution 2: {}\n", .{b});
}
