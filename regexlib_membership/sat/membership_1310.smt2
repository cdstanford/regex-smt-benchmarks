;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d|([a-f]|[A-F])){2}:){5}(\d|([a-f]|[A-F])){2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F5VL8\u008Fyc6:83:69:58:F8:ea"
(define-fun Witness1 () String (seq.++ "\xf5" (seq.++ "V" (seq.++ "L" (seq.++ "8" (seq.++ "\x8f" (seq.++ "y" (seq.++ "c" (seq.++ "6" (seq.++ ":" (seq.++ "8" (seq.++ "3" (seq.++ ":" (seq.++ "6" (seq.++ "9" (seq.++ ":" (seq.++ "5" (seq.++ "8" (seq.++ ":" (seq.++ "F" (seq.++ "8" (seq.++ ":" (seq.++ "e" (seq.++ "a" ""))))))))))))))))))))))))
;witness2: "heA:3F:D9:dC:B6:EA"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "e" (seq.++ "A" (seq.++ ":" (seq.++ "3" (seq.++ "F" (seq.++ ":" (seq.++ "D" (seq.++ "9" (seq.++ ":" (seq.++ "d" (seq.++ "C" (seq.++ ":" (seq.++ "B" (seq.++ "6" (seq.++ ":" (seq.++ "E" (seq.++ "A" "")))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 5 5) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.union (re.range "A" "F") (re.range "a" "f")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
