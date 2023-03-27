;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:4\d{3})|(?:5[1-5]\d{2})|(?:6011)|(?:3[68]\d{2})|(?:30[012345]\d))[ -]?(\d{4})[ -]?(\d{4})[ -]?(\d{4}|3[4,7]\d{13})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3033-8959-9828 373715248339568"
(define-fun Witness1 () String (str.++ "3" (str.++ "0" (str.++ "3" (str.++ "3" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "8" (str.++ " " (str.++ "3" (str.++ "7" (str.++ "3" (str.++ "7" (str.++ "1" (str.++ "5" (str.++ "2" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "3" (str.++ "9" (str.++ "5" (str.++ "6" (str.++ "8" "")))))))))))))))))))))))))))))))
;witness2: "3896 8913-59888793"
(define-fun Witness2 () String (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "3" (str.++ "-" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "3" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" "")))))(re.union (re.++ (re.range "3" "3")(re.++ (re.union (re.range "6" "6") (re.range "8" "8")) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (str.to_re (str.++ "3" (str.++ "0" "")))(re.++ (re.range "0" "5") (re.range "0" "9")))))))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.union ((_ re.loop 4 4) (re.range "0" "9")) (re.++ (re.range "3" "3")(re.++ (re.union (re.range "," ",")(re.union (re.range "4" "4") (re.range "7" "7"))) ((_ re.loop 13 13) (re.range "0" "9"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
