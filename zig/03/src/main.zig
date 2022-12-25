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

    fn makeMap(_: @This(), allocator: std.mem.Allocator, chars: []const u8) !std.AutoArrayHashMap(u8, void) {
        var map = std.AutoArrayHashMap(u8, void).init(allocator);
        for (chars[0..chars.len]) |c| try map.put(c, {});
        return map;
    }

    fn priority(_: @This(), c: u8) i32 {
        return switch (c) {
            'a'...'z' => c - 'a' + 1,
            'A'...'Z' => c - 'A' + 1 + 26,
            else => unreachable,
        };
    }

    fn a(self: *@This()) !i32 {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        var sum: i32 = 0;

        while (self.file.next()) |line| {
            const mid: usize = @divExact(line.len, 2);
            var map = try self.makeMap(gpa.allocator(), line[mid..line.len]);

            for (line[0..mid]) |c| {
                if (map.contains(c)) {
                    sum += self.priority(c);
                    break;
                }
            }
        }

        return sum;
    }

    fn b(self: *@This()) !i32 {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        var sum: i32 = 0;

        while (self.file.next()) |_x| {
            var _y = self.file.next().?;
            var _z = self.file.next().?;

            var x = try self.makeMap(gpa.allocator(), _x);
            var y = try self.makeMap(gpa.allocator(), _y);
            var z = try self.makeMap(gpa.allocator(), _z);

            for (x.keys()) |k| {
                if (y.contains(k) and z.contains(k)) sum += self.priority(k);
            }
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

    std.debug.print("\nSolution 1: {}\n", .{a});
    std.debug.print("Solution 2: {}\n", .{b});
}
