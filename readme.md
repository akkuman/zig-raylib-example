# Example(use raylib in zig)

尝试使用zig调用raylib的样例

This only is a example that try to use raylib in zig, details can be seen in [build.zig](./build.zig)

这个只是尝试使用 zig 调用 raylib 的样例，具体的可以在 [build.zig](./build.zig) 中看到

[src/main.zig](src/main.zig) is the code in the [offical example](https://ziglang.org/learn/samples/#c-interoperability)

[src/main.zig](src/main.zig) 为 [官方样例](https://ziglang.org/learn/samples/#c-interoperability) 中的代码

## Static Build(静态编译)


only for windows

这个示例仅仅针对windows

```shell
vcpkg install raylib:x64-windows-static
zig build -Dvcpkg -Dwindows -Drelease-small
```

## Dynamic Build(动态编译)

```shell
vcpkg install raylib:x64-windows

# you need to replace `exe.addVcpkgPaths(.static)` to `exe.addVcpkgPaths(.dynamic)` in build.zig
# 你需要将 build.zig 中的 `exe.addVcpkgPaths(.static)` 替换为 `exe.addVcpkgPaths(.dynamic)`

zig build -Dvcpkg -Dwindows -Drelease-small
```

then you need to copy the raylib.dll from `{vcpkg_root}\installed\x64-windows\bin\` to `zig-out` directory.

然后你需要将位于 `{vcpkg_root}\installed\x64-windows\bin\` 的 raylib.dll 复制到zig-out目录
