;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = IT\d{2}[ ][a-zA-Z]\d{3}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{3}|IT\d{2}[a-zA-Z]\d{22}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00BBx\u00E4IT84Q1485325913916895690898g"
(define-fun Witness1 () String (seq.++ "\xbb" (seq.++ "x" (seq.++ "\xe4" (seq.++ "I" (seq.++ "T" (seq.++ "8" (seq.++ "4" (seq.++ "Q" (seq.++ "1" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "3" (seq.++ "2" (seq.++ "5" (seq.++ "9" (seq.++ "1" (seq.++ "3" (seq.++ "9" (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "6" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "g" ""))))))))))))))))))))))))))))))))
;witness2: "}IT84 J547 4194 9786 1963 8886 827"
(define-fun Witness2 () String (seq.++ "}" (seq.++ "I" (seq.++ "T" (seq.++ "8" (seq.++ "4" (seq.++ " " (seq.++ "J" (seq.++ "5" (seq.++ "4" (seq.++ "7" (seq.++ " " (seq.++ "4" (seq.++ "1" (seq.++ "9" (seq.++ "4" (seq.++ " " (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "6" (seq.++ " " (seq.++ "1" (seq.++ "9" (seq.++ "6" (seq.++ "3" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ " " (seq.++ "8" (seq.++ "2" (seq.++ "7" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "I" (seq.++ "T" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 3 3) (re.range "0" "9")))))))))))))))) (re.++ (str.to_re (seq.++ "I" (seq.++ "T" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 22 22) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
