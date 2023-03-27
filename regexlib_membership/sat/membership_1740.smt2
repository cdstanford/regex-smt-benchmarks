;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]\d|[1][0-2])\/([0-2]\d|[3][0-1])\/([2][01]|[1][6-9])\d{2}(\s([0-1]\d|[2][0-3])(\:[0-5]\d){1,2})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "11/20/2088\u008520:18:41"
(define-fun Witness1 () String (str.++ "1" (str.++ "1" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "\u{85}" (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "1" (str.++ "8" (str.++ ":" (str.++ "4" (str.++ "1" ""))))))))))))))))))))
;witness2: "08/20/1995\u00A020:34"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "\u{a0}" (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "3" (str.++ "4" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "1")) (re.++ (re.range "1" "1") (re.range "6" "9")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))) ((_ re.loop 1 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
