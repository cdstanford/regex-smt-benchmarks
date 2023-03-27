;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (-\d{1,} | \d{1,} | \d{1,}-\d{1,} | \d{1,}-)(,(-\d{1,} | \d{1,} | \d{1,}-\d{1,} | \d{1,}))*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C3-9 "
(define-fun Witness1 () String (str.++ "\u{c3}" (str.++ "-" (str.++ "9" (str.++ " " "")))))
;witness2: " 8-\x1F\u00BC2"
(define-fun Witness2 () String (str.++ " " (str.++ "8" (str.++ "-" (str.++ "\u{1f}" (str.++ "\u{bc}" (str.++ "2" "")))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "-" "-")(re.++ (re.+ (re.range "0" "9")) (re.range " " " ")))(re.union (re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9")) (re.range " " " ")))(re.union (re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.+ (re.range "0" "9")) (re.range " " " "))))) (re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9")) (re.range "-" "-")))))) (re.* (re.++ (re.range "," ",") (re.union (re.++ (re.range "-" "-")(re.++ (re.+ (re.range "0" "9")) (re.range " " " ")))(re.union (re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9")) (re.range " " " ")))(re.union (re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.+ (re.range "0" "9")) (re.range " " " "))))) (re.++ (re.range " " " ") (re.+ (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
