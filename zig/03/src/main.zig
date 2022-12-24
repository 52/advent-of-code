const std = @import("std");
const testing = std.testing;

const data = @embedFile("input");

const Solution = struct {
    file: std.mem.SplitIterator(u8),

    fn init() !@This() {
        var file = std.mem.split(u8, data, "\n");
        return Solution{ .file = file };
    }

    fn rewind(self: *@This()) !void {
        self.file.reset();
    }

    fn a(self: *@This()) !i32 {
        while (self.file.next()) |line| {
            std.debug.print("{s}\n", .{line});
        }

        return 0;
    }
};

test {
    std.testing.log_level = .debug;
    var solution = try Solution.init();

    var a = try solution.a();
    solution.rewind();

    std.debug.print("\nSolution 1: {}\n", .{a});
}
