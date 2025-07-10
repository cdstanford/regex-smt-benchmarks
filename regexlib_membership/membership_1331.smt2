;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Za-z0-9.]+\s*)+,
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".,"
(define-fun Witness1 () String (str.++ "." (str.++ "," "")))
;witness2: "2.\u00A0DNK47\u00A0 ,\u00D2l\u0094"
(define-fun Witness2 () String (str.++ "2" (str.++ "." (str.++ "\u{a0}" (str.++ "D" (str.++ "N" (str.++ "K" (str.++ "4" (str.++ "7" (str.++ "\u{a0}" (str.++ " " (str.++ "," (str.++ "\u{d2}" (str.++ "l" (str.++ "\u{94}" "")))))))))))))))

(assert (= regexA (re.++ (re.+ (re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.range "," ","))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
