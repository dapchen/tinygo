target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7m-none-eabi"

@"internal/task.stackSizes" = global [1 x i32] [i32 1024], section ".tinygo_stacksizes", align 4
@llvm.used = appending global [2 x ptr] [ptr @"internal/task.stackSizes", ptr @"runtime.run$1$gowrapper"]

declare i32 @"internal/task.getGoroutineStackSize"(i32, ptr, ptr)

declare void @"runtime.run$1$gowrapper"(ptr)

declare void @"internal/task.start"(i32, ptr, i32)

define void @Reset_Handler() {
entry:
  %stacksize1 = load i32, ptr @"internal/task.stackSizes", align 4
  call void @"internal/task.start"(i32 ptrtoint (ptr @"runtime.run$1$gowrapper" to i32), ptr undef, i32 %stacksize1)
  ret void
}
