;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{1,2}[0-9A-Za-z]{1,2}[ ]?[0-9]{0,1}[A-Za-z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "h6e 4Rk"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "6" (seq.++ "e" (seq.++ " " (seq.++ "4" (seq.++ "R" (seq.++ "k" ""))))))))
;witness2: "YN88ZB"
(define-fun Witness2 () String (seq.++ "Y" (seq.++ "N" (seq.++ "8" (seq.++ "8" (seq.++ "Z" (seq.++ "B" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 1 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
