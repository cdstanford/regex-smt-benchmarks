;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d|([a-f]|[A-F])){2}:){5}(\d|([a-f]|[A-F])){2}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F5VL8\u008Fyc6:83:69:58:F8:ea"
(define-fun Witness1 () String (str.++ "\u{f5}" (str.++ "V" (str.++ "L" (str.++ "8" (str.++ "\u{8f}" (str.++ "y" (str.++ "c" (str.++ "6" (str.++ ":" (str.++ "8" (str.++ "3" (str.++ ":" (str.++ "6" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "8" (str.++ ":" (str.++ "F" (str.++ "8" (str.++ ":" (str.++ "e" (str.++ "a" ""))))))))))))))))))))))))
;witness2: "heA:3F:D9:dC:B6:EA"
(define-fun Witness2 () String (str.++ "h" (str.++ "e" (str.++ "A" (str.++ ":" (str.++ "3" (str.++ "F" (str.++ ":" (str.++ "D" (str.++ "9" (str.++ ":" (str.++ "d" (str.++ "C" (str.++ ":" (str.++ "B" (str.++ "6" (str.++ ":" (str.++ "E" (str.++ "A" "")))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 5 5) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.union (re.range "A" "F") (re.range "a" "f")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
