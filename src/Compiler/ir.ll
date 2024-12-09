; ModuleID = 'SimpleModule'
source_filename = "SimpleModule"

define i32 @main() {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 5, ptr %a, align 4
  %0 = load i32, ptr %a, align 4
  %multmp = mul i32 %0, 5
  store i32 %multmp, ptr %b, align 4
  %1 = load i32, ptr %b, align 4
  %addtmp = add i32 %1, 2
  %multmp1 = mul i32 %addtmp, 5
  %2 = load i32, ptr %a, align 4
  %divtmp = sdiv i32 %multmp1, %2
  store i32 %divtmp, ptr %c, align 4
  ret i32 0
}
