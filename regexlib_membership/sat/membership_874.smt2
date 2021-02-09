;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0](\d{9})|([0](\d{2})( |-)((\d{3}))( |-)(\d{4}))|[0](\d{2})( |-)(\d{7})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "089 2257624"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "2" (seq.++ "2" (seq.++ "5" (seq.++ "7" (seq.++ "6" (seq.++ "2" (seq.++ "4" ""))))))))))))
;witness2: "091 8289696\u00A2"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "1" (seq.++ " " (seq.++ "8" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "6" (seq.++ "\xa2" "")))))))))))))

(assert (= regexA (re.union (re.++ (re.range "0" "0") ((_ re.loop 9 9) (re.range "0" "9")))(re.union (re.++ (re.range "0" "0")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))))) (re.++ (re.range "0" "0")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "-")) ((_ re.loop 7 7) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
