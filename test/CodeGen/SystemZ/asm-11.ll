; Test the "I" constraint (8-bit unsigned constants).
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -no-integrated-as | FileCheck %s

; Test 1 below the first valid value.
define i32 @f1() {
; CHECK-LABEL: f1:
; CHECK: lhi [[REG:%r[0-5]]], -1
; CHECK: blah %r2 [[REG]]
; CHECK: br %r14
  %val = call i32 asm "blah $0 $1", "=&r,rI" (i32 -1)
  ret i32 %val
}

; Test the first valid value.
define i32 @f2() {
; CHECK-LABEL: f2:
; CHECK: blah %r2 0
; CHECK: br %r14
  %val = call i32 asm "blah $0 $1", "=&r,rI" (i32 0)
  ret i32 %val
}

; Test the last valid value.
define i32 @f3() {
; CHECK-LABEL: f3:
; CHECK: blah %r2 255
; CHECK: br %r14
  %val = call i32 asm "blah $0 $1", "=&r,rI" (i32 255)
  ret i32 %val
}

; Test 1 above the last valid value.
define i32 @f4() {
; CHECK-LABEL: f4:
; CHECK: lhi [[REG:%r[0-5]]], 256
; CHECK: blah %r2 [[REG]]
; CHECK: br %r14
  %val = call i32 asm "blah $0 $1", "=&r,rI" (i32 256)
  ret i32 %val
}
