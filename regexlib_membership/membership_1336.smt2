;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \{[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{CE9386FD-a87a-cCF8-7F82-cd9513AD1E29}"
(define-fun Witness1 () String (str.++ "{" (str.++ "C" (str.++ "E" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "6" (str.++ "F" (str.++ "D" (str.++ "-" (str.++ "a" (str.++ "8" (str.++ "7" (str.++ "a" (str.++ "-" (str.++ "c" (str.++ "C" (str.++ "F" (str.++ "8" (str.++ "-" (str.++ "7" (str.++ "F" (str.++ "8" (str.++ "2" (str.++ "-" (str.++ "c" (str.++ "d" (str.++ "9" (str.++ "5" (str.++ "1" (str.++ "3" (str.++ "A" (str.++ "D" (str.++ "1" (str.++ "E" (str.++ "2" (str.++ "9" (str.++ "}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "\u009F{FAfBbd4A-3FAa-Caab-c905-EF9D88665f53}\u008C"
(define-fun Witness2 () String (str.++ "\u{9f}" (str.++ "{" (str.++ "F" (str.++ "A" (str.++ "f" (str.++ "B" (str.++ "b" (str.++ "d" (str.++ "4" (str.++ "A" (str.++ "-" (str.++ "3" (str.++ "F" (str.++ "A" (str.++ "a" (str.++ "-" (str.++ "C" (str.++ "a" (str.++ "a" (str.++ "b" (str.++ "-" (str.++ "c" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "-" (str.++ "E" (str.++ "F" (str.++ "9" (str.++ "D" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "6" (str.++ "5" (str.++ "f" (str.++ "5" (str.++ "3" (str.++ "}" (str.++ "\u{8c}" "")))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "{" "{")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "}" "}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
