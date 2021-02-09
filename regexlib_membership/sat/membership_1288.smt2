;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Year>(19|20)[0-9][0-9])-(?<Month>0[1-9]|1[0-2])-(?<Day>0[1-9]|[12][0-9]|3[01])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1936-12-01J"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "9" (seq.++ "3" (seq.++ "6" (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "1" (seq.++ "J" ""))))))))))))
;witness2: "\xB2098-12-06"
(define-fun Witness2 () String (seq.++ "\x0b" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "6" ""))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" ""))))(re.++ (re.range "0" "9") (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
