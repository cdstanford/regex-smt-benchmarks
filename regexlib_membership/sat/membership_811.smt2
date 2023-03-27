;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Year>(?:\d{4}|\d{2}))-(?<Month>\d{1,2})-(?<Day>\d{1,2})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ">44-9-9\x9\x18\u00FD\u00A5i\u00C6"
(define-fun Witness1 () String (str.++ ">" (str.++ "4" (str.++ "4" (str.++ "-" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "\u{09}" (str.++ "\u{18}" (str.++ "\u{fd}" (str.++ "\u{a5}" (str.++ "i" (str.++ "\u{c6}" ""))))))))))))))
;witness2: "q0H39-99-22"
(define-fun Witness2 () String (str.++ "q" (str.++ "0" (str.++ "H" (str.++ "3" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "2" ""))))))))))))

(assert (= regexA (re.++ (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 2) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
