const std = @import("std");
const testing = std.testing;

const data = @embedFile("input");

const Solution = struct {
    file: std.mem.SplitIterator(u8),

    fn init() !@This() {
        var file = std.mem.split(u8, data, "\n");
        return Solution{ .file = file };
    }

    fn rewind(self: *@This()) void {
        self.file.reset();
    }

    fn sum(arr: [3]i32) i32 {
        var _sum: i32 = 0;
        for (arr) |i| _sum = _sum + i;
        return _sum;
    }

    fn a(self: *@This()) !i32 {
        var max: i32 = 0;
        var curr: i32 = 0;

        while (self.file.next()) |line| {
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

    fn b(self: *@This()) !i32 {
        var map = [3]i32{ 0, 0, 0 };
        var curr: i32 = 0;

        while (self.file.next()) |line| {
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

    var a = try solution.a();
    solution.rewind();
    var b = try solution.b();

    try testing.expectEqual(a, 70720);
    try testing.expectEqual(b, 207148);

    std.debug.print("\nSolution 1: {}\n", .{a});
    std.debug.print("Solution 2: {}\n", .{b});
}
