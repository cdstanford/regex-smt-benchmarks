;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \{[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{CE9386FD-a87a-cCF8-7F82-cd9513AD1E29}"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "C" (seq.++ "E" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "6" (seq.++ "F" (seq.++ "D" (seq.++ "-" (seq.++ "a" (seq.++ "8" (seq.++ "7" (seq.++ "a" (seq.++ "-" (seq.++ "c" (seq.++ "C" (seq.++ "F" (seq.++ "8" (seq.++ "-" (seq.++ "7" (seq.++ "F" (seq.++ "8" (seq.++ "2" (seq.++ "-" (seq.++ "c" (seq.++ "d" (seq.++ "9" (seq.++ "5" (seq.++ "1" (seq.++ "3" (seq.++ "A" (seq.++ "D" (seq.++ "1" (seq.++ "E" (seq.++ "2" (seq.++ "9" (seq.++ "}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "\u009F{FAfBbd4A-3FAa-Caab-c905-EF9D88665f53}\u008C"
(define-fun Witness2 () String (seq.++ "\x9f" (seq.++ "{" (seq.++ "F" (seq.++ "A" (seq.++ "f" (seq.++ "B" (seq.++ "b" (seq.++ "d" (seq.++ "4" (seq.++ "A" (seq.++ "-" (seq.++ "3" (seq.++ "F" (seq.++ "A" (seq.++ "a" (seq.++ "-" (seq.++ "C" (seq.++ "a" (seq.++ "a" (seq.++ "b" (seq.++ "-" (seq.++ "c" (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "-" (seq.++ "E" (seq.++ "F" (seq.++ "9" (seq.++ "D" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "6" (seq.++ "5" (seq.++ "f" (seq.++ "5" (seq.++ "3" (seq.++ "}" (seq.++ "\x8c" "")))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "{" "{")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "}" "}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
