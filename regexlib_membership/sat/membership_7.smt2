;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [NS] \d{1,}(\:[0-5]\d){2}.{0,1}\d{0,},[EW] \d{1,}(\:[0-5]\d){2}.{0,1}\d{0,}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "N 488:14:38\u00AD87,E 9:03:43"
(define-fun Witness1 () String (seq.++ "N" (seq.++ " " (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ ":" (seq.++ "1" (seq.++ "4" (seq.++ ":" (seq.++ "3" (seq.++ "8" (seq.++ "\xad" (seq.++ "8" (seq.++ "7" (seq.++ "," (seq.++ "E" (seq.++ " " (seq.++ "9" (seq.++ ":" (seq.++ "0" (seq.++ "3" (seq.++ ":" (seq.++ "4" (seq.++ "3" "")))))))))))))))))))))))))
;witness2: "\u00BDS 7629337:57:59\u00C8,E 9863768:02:583"
(define-fun Witness2 () String (seq.++ "\xbd" (seq.++ "S" (seq.++ " " (seq.++ "7" (seq.++ "6" (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "3" (seq.++ "7" (seq.++ ":" (seq.++ "5" (seq.++ "7" (seq.++ ":" (seq.++ "5" (seq.++ "9" (seq.++ "\xc8" (seq.++ "," (seq.++ "E" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "3" (seq.++ "7" (seq.++ "6" (seq.++ "8" (seq.++ ":" (seq.++ "0" (seq.++ "2" (seq.++ ":" (seq.++ "5" (seq.++ "8" (seq.++ "3" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.range "N" "N") (re.range "S" "S"))(re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.union (re.range "E" "E") (re.range "W" "W"))(re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.range "0" "9"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
