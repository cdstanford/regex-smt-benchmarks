;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 714|760|949|619|909|951|818|310|323|213|323|562|626-\d{3}-\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AE323\u00E5"
(define-fun Witness1 () String (seq.++ "\xae" (seq.++ "3" (seq.++ "2" (seq.++ "3" (seq.++ "\xe5" ""))))))
;witness2: "714\u00C6\u00B9y"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "1" (seq.++ "4" (seq.++ "\xc6" (seq.++ "\xb9" (seq.++ "y" "")))))))

(assert (= regexA (re.union (str.to_re (seq.++ "7" (seq.++ "1" (seq.++ "4" ""))))(re.union (str.to_re (seq.++ "7" (seq.++ "6" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "9" (seq.++ "4" (seq.++ "9" ""))))(re.union (str.to_re (seq.++ "6" (seq.++ "1" (seq.++ "9" ""))))(re.union (str.to_re (seq.++ "9" (seq.++ "0" (seq.++ "9" ""))))(re.union (str.to_re (seq.++ "9" (seq.++ "5" (seq.++ "1" ""))))(re.union (str.to_re (seq.++ "8" (seq.++ "1" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "3" (seq.++ "1" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "3" (seq.++ "2" (seq.++ "3" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "1" (seq.++ "3" ""))))(re.union (str.to_re (seq.++ "3" (seq.++ "2" (seq.++ "3" ""))))(re.union (str.to_re (seq.++ "5" (seq.++ "6" (seq.++ "2" "")))) (re.++ (str.to_re (seq.++ "6" (seq.++ "2" (seq.++ "6" (seq.++ "-" "")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
