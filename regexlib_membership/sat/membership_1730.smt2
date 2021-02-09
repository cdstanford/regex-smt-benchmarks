;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0]?[1-9]|[1][0-2])[\/|\-|\.]([0-2]\d|[3][0-1]|[1-9])[\/|\-|\.]([2][0])?\d{2}\s+((([0][0-9]|[1][0-2]|[0-9])[\:|\-|\.]([0-5]\d)\s*([aApP][mM])?)|(([0-1][0-9]|[2][0-3]|[0-9])[\:|\-|\.]([0-5]\d))))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4-30|2028\u00A0\xD\u00A0 12:35"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "-" (seq.++ "3" (seq.++ "0" (seq.++ "|" (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ "8" (seq.++ "\xa0" (seq.++ "\x0d" (seq.++ "\xa0" (seq.++ " " (seq.++ "1" (seq.++ "2" (seq.++ ":" (seq.++ "3" (seq.++ "5" "")))))))))))))))))))
;witness2: "10-23-2099\xC22|51"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "0" (seq.++ "-" (seq.++ "2" (seq.++ "3" (seq.++ "-" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "\x0c" (seq.++ "2" (seq.++ "2" (seq.++ "|" (seq.++ "5" (seq.++ "1" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "-" "/") (re.range "|" "|"))(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9"))(re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (re.range "1" "9")))(re.++ (re.union (re.range "-" "/") (re.range "|" "|"))(re.++ (re.opt (str.to_re (seq.++ "2" (seq.++ "0" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.range "0" "9")))(re.++ (re.union (re.range "-" ".")(re.union (re.range ":" ":") (re.range "|" "|")))(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))) (re.union (re.range "M" "M") (re.range "m" "m")))))))) (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "3")) (re.range "0" "9")))(re.++ (re.union (re.range "-" ".")(re.union (re.range ":" ":") (re.range "|" "|"))) (re.++ (re.range "0" "5") (re.range "0" "9")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
