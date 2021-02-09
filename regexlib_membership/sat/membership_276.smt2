;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \A(([a-zA-Z]{1,2}\d{1,2})|([a-zA-Z]{2}\d[a-zA-Z]{1}))\x20{0,1}\d[a-zA-Z]{2}\Z
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "OR0c 8ZX"
(define-fun Witness1 () String (seq.++ "O" (seq.++ "R" (seq.++ "0" (seq.++ "c" (seq.++ " " (seq.++ "8" (seq.++ "Z" (seq.++ "X" "")))))))))
;witness2: "ZE8 9Os"
(define-fun Witness2 () String (seq.++ "Z" (seq.++ "E" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "O" (seq.++ "s" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 1 2) (re.range "0" "9"))) (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "0" "9") (re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
