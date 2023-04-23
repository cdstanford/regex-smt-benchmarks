;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = SE\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|SE\d{22}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "SE8550477181910399268688\u0087"
(define-fun Witness1 () String (str.++ "S" (str.++ "E" (str.++ "8" (str.++ "5" (str.++ "5" (str.++ "0" (str.++ "4" (str.++ "7" (str.++ "7" (str.++ "1" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "1" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ "6" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "\u{87}" ""))))))))))))))))))))))))))
;witness2: "SE9595044859747599949889\u00FDg\u00D1\u00C1\xCf"
(define-fun Witness2 () String (str.++ "S" (str.++ "E" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "5" (str.++ "0" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "\u{fd}" (str.++ "g" (str.++ "\u{d1}" (str.++ "\u{c1}" (str.++ "\u{0c}" (str.++ "f" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "S" (str.++ "E" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (str.++ "S" (str.++ "E" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
