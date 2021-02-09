;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(GB){0,1}([1-9][0-9]{2}\ [0-9]{4}\ [0-9]{2})|([1-9][0-9]{2}\ [0-9]{4}\ [0-9]{2}\ [0-9]{3})|((GD|HA)[0-9]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "GB880 9198 85\u00CA"
(define-fun Witness1 () String (seq.++ "G" (seq.++ "B" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ " " (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "5" (seq.++ "\xca" "")))))))))))))))
;witness2: "159 6435 81\u00B8\x1E\u00E4\u00B1\u00F79"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "5" (seq.++ "9" (seq.++ " " (seq.++ "6" (seq.++ "4" (seq.++ "3" (seq.++ "5" (seq.++ " " (seq.++ "8" (seq.++ "1" (seq.++ "\xb8" (seq.++ "\x1e" (seq.++ "\xe4" (seq.++ "\xb1" (seq.++ "\xf7" (seq.++ "9" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "G" (seq.++ "B" "")))) (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9")))))))))(re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 3 3) (re.range "0" "9"))))))))) (re.++ (re.++ (re.union (str.to_re (seq.++ "G" (seq.++ "D" ""))) (str.to_re (seq.++ "H" (seq.++ "A" "")))) ((_ re.loop 3 3) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
