;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0]?[1-9]|[1][0-2])[\/|\-|\.]([0-2]\d|[3][0-1]|[1-9])[\/|\-|\.]([2][0])?\d{2}\s+((([0][0-9]|[1][0-2]|[0-9])[\:|\-|\.]([0-5]\d)\s*([aApP][mM])?)|(([0-1][0-9]|[2][0-3]|[0-9])[\:|\-|\.]([0-5]\d))))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4-30|2028\u00A0\xD\u00A0 12:35"
(define-fun Witness1 () String (str.++ "4" (str.++ "-" (str.++ "3" (str.++ "0" (str.++ "|" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ "8" (str.++ "\u{a0}" (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ " " (str.++ "1" (str.++ "2" (str.++ ":" (str.++ "3" (str.++ "5" "")))))))))))))))))))
;witness2: "10-23-2099\xC22|51"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "-" (str.++ "2" (str.++ "3" (str.++ "-" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "\u{0c}" (str.++ "2" (str.++ "2" (str.++ "|" (str.++ "5" (str.++ "1" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "-" "/") (re.range "|" "|"))(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9"))(re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (re.range "1" "9")))(re.++ (re.union (re.range "-" "/") (re.range "|" "|"))(re.++ (re.opt (str.to_re (str.++ "2" (str.++ "0" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.range "0" "9")))(re.++ (re.union (re.range "-" ".")(re.union (re.range ":" ":") (re.range "|" "|")))(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.opt (re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))) (re.union (re.range "M" "M") (re.range "m" "m")))))))) (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "3")) (re.range "0" "9")))(re.++ (re.union (re.range "-" ".")(re.union (re.range ":" ":") (re.range "|" "|"))) (re.++ (re.range "0" "5") (re.range "0" "9")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
