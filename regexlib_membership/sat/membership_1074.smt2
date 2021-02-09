;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = SE\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|SE\d{22}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "SE8550477181910399268688\u0087"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "E" (seq.++ "8" (seq.++ "5" (seq.++ "5" (seq.++ "0" (seq.++ "4" (seq.++ "7" (seq.++ "7" (seq.++ "1" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "1" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "6" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "\x87" ""))))))))))))))))))))))))))
;witness2: "SE9595044859747599949889\u00FDg\u00D1\u00C1\xCf"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "E" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "5" (seq.++ "0" (seq.++ "4" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "7" (seq.++ "4" (seq.++ "7" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "\xfd" (seq.++ "g" (seq.++ "\xd1" (seq.++ "\xc1" (seq.++ "\x0c" (seq.++ "f" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "S" (seq.++ "E" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (seq.++ "S" (seq.++ "E" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
