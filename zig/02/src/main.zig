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

    fn normalize(_: @This(), x: u8) !u8 {
        var s: u8 = switch (x) {
            'A', 'X' => 0,
            'B', 'Y' => 1,
            'C', 'Z' => 2,
            else => @panic("Error: Received invalid input."),
        };
        return s;
    }

    fn score(_: @This(), x: u8, y: u8) i32 {
        var map: [3][3]u8 = .{
            .{ 1 + 3, 2 + 6, 3 + 0 },
            .{ 1 + 0, 2 + 3, 3 + 6 },
            .{ 1 + 6, 2 + 0, 3 + 3 },
        };
        return map[x][y];
    }

    fn a(self: @This()) !i32 {
        var _reader = std.io.bufferedReader(self.file.reader());
        var buf: [1024]u8 = undefined;
        var max: i32 = 0;

        while (try _reader.reader().readUntilDelimiterOrEof(&buf, '\n')) |line| {
            var x = try self.normalize(line[0]);
            var y = try self.normalize(line[2]);

            max += self.score(x, y);
        }

        return max;
    }

    fn b(self: @This()) !i32 {
        var _reader = std.io.bufferedReader(self.file.reader());
        var map: [3]u8 = .{ 2, 3, 1 };
        var buf: [1024]u8 = undefined;
        var max: i32 = 0;

        while (try _reader.reader().readUntilDelimiterOrEof(&buf, '\n')) |line| {
            var x = try self.normalize(line[0]);
            var y = try self.normalize(line[2]);

            max += self.score(x, (x + map[y]) % 3);
        }

        return max;
    }
};

test {
    std.testing.log_level = .debug;
    var solution = try Solution.init();
    defer solution.deinit();

    var a = try solution.a();
    try solution.rewind();
    var b = try solution.b();

    try testing.expectEqual(a, 12535);
    try testing.expectEqual(b, 15457);

    std.debug.print("\nSolution 1: {}\n", .{a});
    std.debug.print("Solution 2: {}\n", .{b});
}
