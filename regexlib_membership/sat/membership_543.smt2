;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]+([\.+_-][a-zA-Z0-9]+)*)@(([a-zA-Z0-9]+((\.|[-]{1,2})[a-zA-Z0-9]+)*)\.[a-zA-Z]{2,6})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "qi.Z@D.aO.xd"
(define-fun Witness1 () String (str.++ "q" (str.++ "i" (str.++ "." (str.++ "Z" (str.++ "@" (str.++ "D" (str.++ "." (str.++ "a" (str.++ "O" (str.++ "." (str.++ "x" (str.++ "d" "")))))))))))))
;witness2: "3@0--z.2--49-8e.XLlZKg"
(define-fun Witness2 () String (str.++ "3" (str.++ "@" (str.++ "0" (str.++ "-" (str.++ "-" (str.++ "z" (str.++ "." (str.++ "2" (str.++ "-" (str.++ "-" (str.++ "4" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "e" (str.++ "." (str.++ "X" (str.++ "L" (str.++ "l" (str.++ "Z" (str.++ "K" (str.++ "g" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.union (re.range "+" "+")(re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.union (re.range "." ".") ((_ re.loop 1 2) (re.range "-" "-"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range "." ".") ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
