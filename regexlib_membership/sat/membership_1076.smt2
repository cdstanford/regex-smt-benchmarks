;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = AD\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|AD\d{22}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "z^AD69 8920 4983 9808 7216 3955"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "^" (seq.++ "A" (seq.++ "D" (seq.++ "6" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "0" (seq.++ " " (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ " " (seq.++ "7" (seq.++ "2" (seq.++ "1" (seq.++ "6" (seq.++ " " (seq.++ "3" (seq.++ "9" (seq.++ "5" (seq.++ "5" ""))))))))))))))))))))))))))))))))
;witness2: "\xBAD9846833028376882899894"
(define-fun Witness2 () String (seq.++ "\x0b" (seq.++ "A" (seq.++ "D" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "6" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "0" (seq.++ "2" (seq.++ "8" (seq.++ "3" (seq.++ "7" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "4" ""))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "A" (seq.++ "D" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (seq.++ "A" (seq.++ "D" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
