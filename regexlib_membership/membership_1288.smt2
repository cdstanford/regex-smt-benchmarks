;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Year>(19|20)[0-9][0-9])-(?<Month>0[1-9]|1[0-2])-(?<Day>0[1-9]|[12][0-9]|3[01])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1936-12-01J"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "3" (str.++ "6" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "0" (str.++ "1" (str.++ "J" ""))))))))))))
;witness2: "\xB2098-12-06"
(define-fun Witness2 () String (str.++ "\u{0b}" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "0" (str.++ "6" ""))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" ""))))(re.++ (re.range "0" "9") (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
