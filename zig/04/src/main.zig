const std = @import("std");
const testing = std.testing;

const data = @embedFile("input");

const Solution = struct {
    file: std.mem.TokenIterator(u8),

    fn init() !@This() {
        var file = std.mem.tokenize(u8, data, "\n");
        return Solution{ .file = file };
    }

    fn rewind(self: *@This()) void {
        self.file.reset();
    }

    fn a(self: *@This()) !i32 {
        var sum: i32 = 0;
        while (self.file.next()) |line| {
            var parts = std.mem.tokenize(u8, line, ",-");

            var w = try std.fmt.parseInt(i32, parts.next().?, 10);
            var x = try std.fmt.parseInt(i32, parts.next().?, 10);
            var y = try std.fmt.parseInt(i32, parts.next().?, 10);
            var z = try std.fmt.parseInt(i32, parts.next().?, 10);

            if ((y - w) * (z - x) <= 0) sum += 1;
        }
        return sum;
    }

    fn b(self: *@This()) !i32 {
        var sum: i32 = 0;
        while (self.file.next()) |line| {
            var parts = std.mem.tokenize(u8, line, ",-");

            var w = try std.fmt.parseInt(i32, parts.next().?, 10);
            var x = try std.fmt.parseInt(i32, parts.next().?, 10);
            var y = try std.fmt.parseInt(i32, parts.next().?, 10);
            var z = try std.fmt.parseInt(i32, parts.next().?, 10);

            if ((z - w) * (y - x) <= 0) sum += 1;
        }
        return sum;
    }
};

test {
    std.testing.log_level = .debug;
    var solution = try Solution.init();

    var a = try solution.a();
    solution.rewind();
    var b = try solution.b();

    try testing.expectEqual(a, 444);

    std.debug.print("\nSolution 1: {}\n", .{a});
    std.debug.print("Solution 2: {}\n", .{b});
}
