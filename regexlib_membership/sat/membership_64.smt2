;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 714|760|949|619|909|951|818|310|323|213|323|562|626-\d{3}-\d{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AE323\u00E5"
(define-fun Witness1 () String (str.++ "\u{ae}" (str.++ "3" (str.++ "2" (str.++ "3" (str.++ "\u{e5}" ""))))))
;witness2: "714\u00C6\u00B9y"
(define-fun Witness2 () String (str.++ "7" (str.++ "1" (str.++ "4" (str.++ "\u{c6}" (str.++ "\u{b9}" (str.++ "y" "")))))))

(assert (= regexA (re.union (str.to_re (str.++ "7" (str.++ "1" (str.++ "4" ""))))(re.union (str.to_re (str.++ "7" (str.++ "6" (str.++ "0" ""))))(re.union (str.to_re (str.++ "9" (str.++ "4" (str.++ "9" ""))))(re.union (str.to_re (str.++ "6" (str.++ "1" (str.++ "9" ""))))(re.union (str.to_re (str.++ "9" (str.++ "0" (str.++ "9" ""))))(re.union (str.to_re (str.++ "9" (str.++ "5" (str.++ "1" ""))))(re.union (str.to_re (str.++ "8" (str.++ "1" (str.++ "8" ""))))(re.union (str.to_re (str.++ "3" (str.++ "1" (str.++ "0" ""))))(re.union (str.to_re (str.++ "3" (str.++ "2" (str.++ "3" ""))))(re.union (str.to_re (str.++ "2" (str.++ "1" (str.++ "3" ""))))(re.union (str.to_re (str.++ "3" (str.++ "2" (str.++ "3" ""))))(re.union (str.to_re (str.++ "5" (str.++ "6" (str.++ "2" "")))) (re.++ (str.to_re (str.++ "6" (str.++ "2" (str.++ "6" (str.++ "-" "")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
