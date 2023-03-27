;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = IT\d{2}[ ][a-zA-Z]\d{3}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{3}|IT\d{2}[a-zA-Z]\d{22}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00BBx\u00E4IT84Q1485325913916895690898g"
(define-fun Witness1 () String (str.++ "\u{bb}" (str.++ "x" (str.++ "\u{e4}" (str.++ "I" (str.++ "T" (str.++ "8" (str.++ "4" (str.++ "Q" (str.++ "1" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "3" (str.++ "2" (str.++ "5" (str.++ "9" (str.++ "1" (str.++ "3" (str.++ "9" (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "6" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "g" ""))))))))))))))))))))))))))))))))
;witness2: "}IT84 J547 4194 9786 1963 8886 827"
(define-fun Witness2 () String (str.++ "}" (str.++ "I" (str.++ "T" (str.++ "8" (str.++ "4" (str.++ " " (str.++ "J" (str.++ "5" (str.++ "4" (str.++ "7" (str.++ " " (str.++ "4" (str.++ "1" (str.++ "9" (str.++ "4" (str.++ " " (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "6" (str.++ " " (str.++ "1" (str.++ "9" (str.++ "6" (str.++ "3" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ " " (str.++ "8" (str.++ "2" (str.++ "7" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "I" (str.++ "T" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 3 3) (re.range "0" "9")))))))))))))))) (re.++ (str.to_re (str.++ "I" (str.++ "T" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 22 22) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
