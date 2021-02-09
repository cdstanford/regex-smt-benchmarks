;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = CZ\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|CZ\d{22}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ACZ1289971868883559219227"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "C" (seq.++ "Z" (seq.++ "1" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "1" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "5" (seq.++ "5" (seq.++ "9" (seq.++ "2" (seq.++ "1" (seq.++ "9" (seq.++ "2" (seq.++ "2" (seq.++ "7" ""))))))))))))))))))))))))))
;witness2: "CZ21 8185 5999 7919 8869 9181"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "Z" (seq.++ "2" (seq.++ "1" (seq.++ " " (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ "5" (seq.++ " " (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "7" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "1" (seq.++ "8" (seq.++ "1" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "C" (seq.++ "Z" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (seq.++ "C" (seq.++ "Z" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
